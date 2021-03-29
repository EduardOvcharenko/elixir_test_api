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
    |> validate_required([:car_brand_id, :model, :year, :body_type, :is_electric])
    |> validate_inclusion(:year,  Enum.to_list(Application.get_env(:test_api,  TestApi.Schema.CarData)[:car_data_min_year]..DateTime.utc_now().year))
    |> validate_inclusion(:body_type,   Application.get_env(:test_api,  TestApi.Schema.CarData)[:body_type_enum])
  end
end
