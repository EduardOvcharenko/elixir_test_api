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
    with {:ok, %CarData{}} <- Schema.create_car_data(params) do
      conn
      |> put_status(:created)
      |> send_resp(200,"")
    end
  end
end
