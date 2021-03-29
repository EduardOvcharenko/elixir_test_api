defmodule TestApi.Repo.Migrations.AddCarDataIndex do
  use Ecto.Migration

  def change do
    create index(:car_data, [:year])
    create index(:car_data, [:is_electric])
  end
end
