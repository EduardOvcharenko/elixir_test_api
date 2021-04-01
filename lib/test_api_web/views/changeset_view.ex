defmodule TestApiWeb.ChangesetView do
  use TestApiWeb, :view

  defp build_err(errors) do
    Enum.map(errors, fn {param_name, {description, error_info}} ->
      %{
        entry: param_name,
        entry_type: "json_data_property",
        rules: get_rules(description, error_info)
      }
    end)
  end

  defp get_rules(description, validation: :inclusion, enum: enum),
    do: %{description: description, params: enum, rule: :inclusion}

  defp get_rules(description, type: type, validation: validation),
    do: %{description: description, params: type, rule: validation}

  defp get_rules(description, validation: :required),
    do: %{description: description, rule: :required}

  defp get_rules(description, _),
    do: %{description: description}

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: %{invalid: build_err(changeset.errors)}}
  end
end
