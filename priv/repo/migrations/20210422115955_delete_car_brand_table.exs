defmodule TestApi.Repo.Migrations.DeleteCarBrandTable do
  use Ecto.Migration

  def change do
    alter table("car_data") do
      add :car_brand, :text
    end

    execute(
      "UPDATE car_data cd SET car_brand = (SELECT Name FROM car_brand WHERE Id = cd.car_brand_id);"
    )

    alter table("car_data") do
      remove :car_brand_id
    end

    drop table(:car_brand)
  end
end
