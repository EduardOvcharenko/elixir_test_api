defmodule TestApiWeb.CarDataController do
  use TestApiWeb, :controller

  alias TestApi.Schema
  alias TestApi.Schema.CarData

  action_fallback TestApiWeb.FallbackController

  def index(conn, params) do
    car_data = Schema.list_car_data(params)
    render(conn, "index.json", car_data: car_data)
  end

  def create(conn, params) do
    with {:ok, %CarData{} = car_data} <- Schema.create_car_data(params) |> IO.inspect(label: "errorrr") do
      conn
      |> put_status(:created)
      |> render("car_data_create_view.json", car_data: car_data)
    end
  end
end
