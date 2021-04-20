defmodule Core.Errors.JsonSchemaError do
  @moduledoc false

  defstruct error: nil, status_code: 422
end

defimpl Core.Errors.JobError, for: Core.Errors.JsonSchemaError do
  alias EView.Views.ValidationError
  def dump(%{error: error}), do: ValidationError.render("422.json", %{schema: error})
end
