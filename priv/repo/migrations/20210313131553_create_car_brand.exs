defmodule TestApi.Repo.Migrations.CreateCarBrand do
  use Ecto.Migration

  def change do
    create table(:car_brand) do
      add :name, :string

      timestamps()
    end
  end
end
