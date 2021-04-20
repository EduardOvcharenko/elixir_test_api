defmodule Core.Errors.ValidationError do
  @moduledoc false

  defstruct message: nil, path: nil, rule: :invalid, params: [], status_code: 422

  def render(%__MODULE__{message: message, params: params, rule: rule, path: path}) do
    {%{
       description: message,
       params: params,
       rule: rule
     }, path}
  end
end

defimpl Core.Errors.JobError, for: Core.Errors.ValidationError do
  def dump(%{} = error) do
    EView.Views.ValidationError.render("422.json", %{
      schema: [Core.Errors.ValidationError.render(error)]
    })
  end
end

defimpl Core.Errors.JobError, for: List do
  def dump([%{} | _] = errors) do
    EView.Views.ValidationError.render("422.json", %{
      schema: Enum.map(errors, &Core.Errors.ValidationError.render/1)
    })
  end
end
