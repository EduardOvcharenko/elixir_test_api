defmodule TestApi.Repo.Migrations.CreateCarData do
  use Ecto.Migration

  def change do
    create table(:car_data) do
      add :model, :string
      add :year, :integer
      add :body_type, :string
      add :is_electric, :boolean, default: false, null: false
      add :car_brand_id, references(:car_brand, on_delete: :nothing)

      timestamps()
    end

    create index(:car_data, [:car_brand_id])
  end
end
