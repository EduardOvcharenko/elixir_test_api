defmodule TestApiWeb.CarDataView do
  use TestApiWeb, :view
  alias TestApiWeb.CarDataView

  def render("index.json", %{car_data: car_data}) do
    %{data: render_many(car_data, CarDataView, "car_data.json")}
  end

  def render("show.json", %{car_data: car_data}) do
    %{data: render_one(car_data, CarDataView, "car_data.json")}
  end

  def render("car_data.json", %{car_data: car_data}) do
    %{
      car_brand: car_data.car_brand,
      model: car_data.model,
      year: car_data.year,
      body_type: car_data.body_type,
      is_electric: car_data.is_electric
    }
  end

  def render("car_data_create_view.json", %{car_data: car_data}) do
    %{
      id: car_data.id,
      model: car_data.model,
      year: car_data.year,
      body_type: car_data.body_type,
      car_brand: car_data.car_brand,
      is_electric: car_data.is_electric
    }
  end
end
