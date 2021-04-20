defmodule TestApiWeb.CarDataController do
  use TestApiWeb, :controller

  alias TestApi.Schema
  alias TestApi.Schema.CarData
  alias TestApi.Validators.JsonSchema

  action_fallback TestApiWeb.FallbackController

  def index(conn, params) do
    with :ok <- JsonSchema.validate(:car_data_search, Map.drop(params, ~w(page page_size))) do
      car_data = Schema.list_car_data(params)
      render(conn, "index.json", car_data: car_data)
    end
  end

  def create(conn, params) do
    with :ok <- JsonSchema.validate(:car_data_create, Map.drop(params, ~w(page page_size))),
         {:ok, %CarData{} = car_data} <- Schema.create_car_data(params) do
      conn
      |> put_status(:created)
      |> render("car_data_create_view.json", car_data: car_data)
    end
  end
end
