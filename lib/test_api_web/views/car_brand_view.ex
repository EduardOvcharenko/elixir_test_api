defmodule TestApiWeb.CarBrandView do
  use TestApiWeb, :view
  alias TestApiWeb.CarBrandView

  def render("index.json", %{car_brand: car_brand}) do
    %{data: render_many(car_brand, CarBrandView, "car_brand.json")}
  end

  def render("show.json", %{car_brand: car_brand}) do
    %{data: render_one(car_brand, CarBrandView, "car_brand.json")}
  end

  def render("car_brand.json", %{car_brand: car_brand}) do
    %{id: car_brand.id, name: car_brand.name}
  end
end
