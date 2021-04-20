defmodule TestApi.Schema.CarData do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "car_data" do
    field :body_type, :string
    field :is_electric, :boolean, default: false
    field :model, :string
    field :year, :integer

    belongs_to :car_brand, TestApi.Schema.CarBrand, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(car_data, attrs) do
    car_data
    |> cast(attrs, [:car_brand_id, :model, :year, :body_type, :is_electric])
    |> validate_year(:year)
  end

  defp validate_year(changeset, field, options \\ []) do
    min_year = Application.get_env(:test_api, TestApi.Schema.CarData)[:car_data_min_year]
    max_year = DateTime.utc_now().year

    validate_change(changeset, field, fn _, year ->
      if year >= min_year && year <= max_year do
        []
      else
        [
          {field,
           options[:message] ||
             "is invalid, value must be between range #{min_year} - #{max_year}"}
        ]
      end
    end)
  end
end
