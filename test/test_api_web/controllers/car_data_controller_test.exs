defmodule TestApiWeb.CarDataControllerTest do
  use TestApiWeb.ConnCase

  alias TestApi.Schema.CarData
  alias TestApi.Repo
  alias TestApi.Schema
  alias TestApi.Cache.Cache

  @table :car_brand_cache
  @cache_key "nhsta"
  @car_brands ["ASTON MARTIN", "TESLA", "JAGUAR", "FERRARI"]

  defp create_car_data do
    Repo.insert!(%CarData{
      model: "F60",
      year: 2011,
      body_type: "sedan",
      is_electric: false,
      car_brand: "FERRARI"
    })

    Repo.insert!(%CarData{
      model: "F70",
      year: 2012,
      body_type: "coupe",
      is_electric: true,
      car_brand: "FERRARI"
    })

    Repo.insert!(%CarData{
      model: "F80",
      year: 2013,
      body_type: "coupe",
      is_electric: true,
      car_brand: "FERRARI"
    })

    Repo.insert!(%CarData{
      model: "X",
      year: 2013,
      body_type: "sedan",
      is_electric: true,
      car_brand: "TESLA"
    })
  end

  describe "index" do
    setup %{conn: conn} do
      create_car_data()
      Cache.start(:car_brand_cache, [:set, :public, :named_table])
      :ets.insert(@table, {@cache_key, @car_brands})
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "lists car_data by valid filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{
          car_brand: "FERRARI",
          body_type: "coupe",
          is_electric: true
        })

      assert [
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by brand filter", %{conn: conn} do
      conn = get(conn, Routes.car_data_path(conn, :index), %{car_brand: "FERRARI"})

      assert [
               %{
                 "body_type" => "sedan",
                 "car_brand" => "FERRARI",
                 "is_electric" => false,
                 "model" => "F60",
                 "year" => 2011
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by brand and body_type filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{car_brand: "FERRARI", body_type: "coupe"})

      assert [
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by brand and is_electric filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{car_brand: "FERRARI", is_electric: true})

      assert [
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by body_type filter", %{conn: conn} do
      conn = get(conn, Routes.car_data_path(conn, :index), %{body_type: "coupe"})

      assert [
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by body_type and is_electric filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{body_type: "coupe", is_electric: true})

      assert [
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "car_brand" => "FERRARI",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by invalid filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{
          car_brand: "Toyoda",
          body_type: "coupe",
          is_electric: true
        })

      assert %{
               "invalid" => [
                 %{
                   "entry" => "$.car_brand",
                   "entry_type" => "json_data_property",
                   "rules" => [
                     %{
                       "description" => "value is not allowed in enum",
                       "params" => %{"values" => ["ASTON MARTIN", "TESLA", "JAGUAR", "FERRARI"]},
                       "raw_description" => "value is not allowed in enum",
                       "rule" => "inclusion"
                     }
                   ]
                 }
               ],
               "message" =>
                 "Validation failed. You can find validators description at our API Manifest: http://docs.apimanifest.apiary.io/#introduction/interacting-with-api/errors.",
               "type" => "validation_failed"
             } = json_response(conn, 422)
    end
  end

  @create_attrs %{
    id: "468234b8-e990-4b26-8936-4e4ef20431e9",
    body_type: "coupe",
    car_brand: "TESLA",
    is_electric: true,
    model: "4000",
    year: 2011
  }

  @invalid_attrs_is_electric %{
    car_brand: "TESLA",
    body_type: "sedan",
    is_electric: 1,
    model: "F40",
    year: 1998
  }
  @invalid_attrs_body_type %{
    car_brand: "TESLA",
    body_type: "aaa",
    is_electric: false,
    model: "F40",
    year: 1998
  }
  @invalid_attrs_year %{
    car_brand: "TESLA",
    body_type: "sedan",
    is_electric: false,
    model: "F40",
    year: 1
  }

  describe "create car_data" do
    test "renders car_data when data is valid", %{conn: conn} do
      conn = post(conn, Routes.car_data_path(conn, :create), @create_attrs)

      assert %{
               "id" => id,
               "body_type" => "coupe",
               "is_electric" => true,
               "car_brand" => "TESLA",
               "model" => "4000",
               "year" => 2011
             } = json_response(conn, 201)

      result = Schema.get_car_data!(id)

      assert %{
               id: ^id,
               body_type: "coupe",
               is_electric: true,
               car_brand: "TESLA",
               model: "4000",
               year: 2011
             } = result
    end

    test "renders errors when data is invalid is electric", %{conn: conn} do
      conn = post(conn, Routes.car_data_path(conn, :create), @invalid_attrs_is_electric)

      assert %{
               "invalid" => [
                 %{
                   "entry" => "$.is_electric",
                   "entry_type" => "json_data_property",
                   "rules" => [
                     %{
                       "description" => "type mismatch. Expected boolean but got integer",
                       "params" => %{"actual" => "integer", "expected" => "boolean"},
                       "raw_description" =>
                         "type mismatch. Expected %{expected} but got %{actual}",
                       "rule" => "cast"
                     }
                   ]
                 }
               ],
               "message" =>
                 "Validation failed. You can find validators description at our API Manifest: http://docs.apimanifest.apiary.io/#introduction/interacting-with-api/errors.",
               "type" => "validation_failed"
             } = json_response(conn, 422)
    end

    test "renders errors when data is invalid body type", %{conn: conn} do
      conn = post(conn, Routes.car_data_path(conn, :create), @invalid_attrs_body_type)

      assert %{
               "invalid" => [
                 %{
                   "entry" => "$.body_type",
                   "entry_type" => "json_data_property",
                   "rules" => [
                     %{
                       "description" => "value is not allowed in enum",
                       "params" => %{"values" => ["sedan", "coupe", "pickup"]},
                       "raw_description" => "value is not allowed in enum",
                       "rule" => "inclusion"
                     }
                   ]
                 }
               ],
               "message" =>
                 "Validation failed. You can find validators description at our API Manifest: http://docs.apimanifest.apiary.io/#introduction/interacting-with-api/errors.",
               "type" => "validation_failed"
             } = json_response(conn, 422)
    end

    test "renders errors when data is invalid year", %{conn: conn} do
      min_year = Application.get_env(:test_api, TestApi.Schema.CarData)[:car_data_min_year]
      max_year = DateTime.utc_now().year
      message = "is invalid, value must be between range #{min_year} - #{max_year}"
      conn = post(conn, Routes.car_data_path(conn, :create), @invalid_attrs_year)

      assert %{
               "invalid" => [
                 %{
                   "entry" => "year",
                   "entry_type" => "json_data_property",
                   "rules" => %{
                     "description" => ^message
                   }
                 }
               ]
             } = json_response(conn, 422)
    end
  end
end
