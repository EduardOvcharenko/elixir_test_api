defmodule TestApi.JsonSchemas.CarDataSearch do
  @moduledoc false

  use Core.Schemata

  def create do
    %Schema{
      properties: %{
        brand: string(),
        body_type:
          enum(Application.get_env(:test_api, TestApi.Schema.CarData)[:body_type_enum], null: true),
        is_electric: string()
      }
    }
  end
end
