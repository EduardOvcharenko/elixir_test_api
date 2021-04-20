defmodule TestApi.JsonSchemas.CarDataCreate do
  @moduledoc false

  use Core.Schemata

  def create do
    %Schema{
      definitions: %{
        uuid: uuid()
      },
      properties: %{
        id: ref("uuid"),
        car_brand_id: uuid(),
        model: string(),
        year: integer(),
        body_type: enum(Application.get_env(:test_api, TestApi.Schema.CarData)[:body_type_enum]),
        is_electric: boolean()
      },
      required: [:car_brand_id, :model, :year, :body_type, :is_electric]
    }
  end
end
