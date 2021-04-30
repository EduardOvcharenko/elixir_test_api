defmodule TestApi.Integrations.Nhtsa do
  @http_client Application.get_env(:test_api, :http_client, TestApi.Nhtsa.Client)
  @table :car_brand_cache
  @cache_key "nhsta"

  def get_brand_list() do
    case :ets.lookup(@table, @cache_key) do
      [{_, value}] ->
        value

      _ ->
        @http_client.get_brands()
        |> cache_brands()
    end
  end

  def cache_brands(car_brands) do
      :ets.insert(@table, {@cache_key, car_brands})
      car_brands
  end
end
