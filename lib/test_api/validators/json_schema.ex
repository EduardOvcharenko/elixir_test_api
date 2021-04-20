defmodule TestApi.Validators.JsonSchema do
  @moduledoc """
  Validates JSON schema
  """

  use JValid
  alias Core.Errors.JsonSchemaError

  def validate(schema_name, attrs, opts \\ []) do
    case schema_name
         |> get_schema()
         |> Schemata.SchemaValidator.validate(attrs) do
      :ok -> :ok
      {:error, error} -> %JsonSchemaError{error: error}
      error -> error
    end
  end

  def get_schema(schema_name) do
    case schema_name do
      :car_data_create -> TestApi.JsonSchemas.CarDataCreate.create()
      :car_data_search -> TestApi.JsonSchemas.CarDataSearch.create()
    end
  end

  def config do
    Application.fetch_env!(:test_api, __MODULE__)
  end
end
