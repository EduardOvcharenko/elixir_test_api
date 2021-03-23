defmodule TestApi.Schema.CarBrand do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "car_brand" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(car_brand, attrs) do
    car_brand
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
