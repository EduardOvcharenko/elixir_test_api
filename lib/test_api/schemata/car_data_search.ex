defmodule TestApi.JsonSchemas.CarDataSearch do
  @moduledoc false

  use Core.Schemata
  alias TestApi.Integrations.Nhtsa

  def create do
    %Schema{
      properties: %{
        car_brand: enum(Nhtsa.get_brand_list()),
        body_type:
          enum(Application.get_env(:test_api, TestApi.Schema.CarData)[:body_type_enum], null: true),
        is_electric: string()
      }
    }
  end
end
