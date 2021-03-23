defmodule TestApiWeb.CarBrandController do
  use TestApiWeb, :controller

  alias TestApi.Schema
  alias TestApi.Schema.CarBrand

  action_fallback TestApiWeb.FallbackController

  def index(conn, _params) do
    car_brand = Schema.list_car_brand()
    render(conn, "index.json", car_brand: car_brand)
  end

  def create(conn, %{"car_brand" => car_brand_params}) do
    with {:ok, %CarBrand{} = car_brand} <- Schema.create_car_brand(car_brand_params) do
      conn
      |> put_status(:created)
      |> render("show.json", car_brand: car_brand)
    end
  end

  def show(conn, %{"id" => id}) do
    car_brand = Schema.get_car_brand!(id)
    render(conn, "show.json", car_brand: car_brand)
  end

  def update(conn, %{"id" => id, "car_brand" => car_brand_params}) do
    car_brand = Schema.get_car_brand!(id)

    with {:ok, %CarBrand{} = car_brand} <- Schema.update_car_brand(car_brand, car_brand_params) do
      render(conn, "show.json", car_brand: car_brand)
    end
  end

  def delete(conn, %{"id" => id}) do
    car_brand = Schema.get_car_brand!(id)

    with {:ok, %CarBrand{}} <- Schema.delete_car_brand(car_brand) do
      send_resp(conn, :no_content, "")
    end
  end
end
