defmodule TestApiWeb.CarDataControllerTest do
  use TestApiWeb.ConnCase

  alias TestApi.Schema.CarData
  alias TestApi.Schema.CarBrand
  alias TestApi.Repo
  alias TestApi.Schema

  setup %{conn: conn} do
    create_car_brands()
    create_car_data()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_car_brands do
    Repo.insert!(%CarBrand{id: "307f491e-e05a-4898-8ff3-f71c0280330e", name: "Toyota"})
    Repo.insert!(%CarBrand{id: "07e526ae-d93b-4ba0-aa37-bb4446c87b3d", name: "Ferrari"})
    Repo.insert!(%CarBrand{id: "24851bbf-9519-4e37-9de3-8d1b11eca666", name: "BMW"})
    Repo.insert!(%CarBrand{id: "abcf229c-be01-46a4-b977-bce4ce35b5db", name: "Tesla"})
  end

  defp create_car_data do
    Repo.insert!(%CarData{
      model: "F60",
      year: 2011,
      body_type: "sedan",
      is_electric: false,
      car_brand_id: "07e526ae-d93b-4ba0-aa37-bb4446c87b3d"
    })

    Repo.insert!(%CarData{
      model: "F70",
      year: 2012,
      body_type: "coupe",
      is_electric: true,
      car_brand_id: "07e526ae-d93b-4ba0-aa37-bb4446c87b3d"
    })

    Repo.insert!(%CarData{
      model: "F80",
      year: 2013,
      body_type: "coupe",
      is_electric: true,
      car_brand_id: "07e526ae-d93b-4ba0-aa37-bb4446c87b3d"
    })

    Repo.insert!(%CarData{
      model: "X",
      year: 2013,
      body_type: "sedan",
      is_electric: true,
      car_brand_id: "abcf229c-be01-46a4-b977-bce4ce35b5db"
    })
  end

  describe "index" do
    test "lists car_data by valid filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{
          brand: "Ferrari",
          body_type: "coupe",
          is_electric: true
        })

      assert [
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by brand filter", %{conn: conn} do
      conn = get(conn, Routes.car_data_path(conn, :index), %{brand: "Ferrari"})

      assert [
               %{
                 "body_type" => "sedan",
                 "brand" => "Ferrari",
                 "is_electric" => false,
                 "model" => "F60",
                 "year" => 2011
               },
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by brand and body_type filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{brand: "Ferrari", body_type: "coupe"})

      assert [
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F80",
                 "year" => 2013
               }
             ] = json_response(conn, 200)["data"]
    end

    test "lists car_data by brand and is_electric filter", %{conn: conn} do
      conn = get(conn, Routes.car_data_path(conn, :index), %{brand: "Ferrari", is_electric: true})

      assert [
               %{
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "brand" => "Ferrari",
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
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "brand" => "Ferrari",
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
                 "brand" => "Ferrari",
                 "body_type" => "coupe",
                 "is_electric" => true,
                 "model" => "F70",
                 "year" => 2012
               },
               %{
                 "brand" => "Ferrari",
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
          brand: "Toyoda",
          body_type: "coupe",
          is_electric: true
        })

      assert [] = json_response(conn, 200)["data"]
    end

    test "lists car_data by empty filter", %{conn: conn} do
      conn =
        get(conn, Routes.car_data_path(conn, :index), %{
          brand: "",
          body_type: "",
          is_electric: true
        })

      assert [] = json_response(conn, 200)["data"]
    end
  end

  @create_attrs %{
    id: "468234b8-e990-4b26-8936-4e4ef20431e9",
    body_type: "coupe",
    car_brand_id: "abcf229c-be01-46a4-b977-bce4ce35b5db",
    is_electric: true,
    model: "4000",
    year: 2011
  }

  @invalid_attrs_is_electric %{
    car_brand_id: "abcf229c-be01-46a4-b977-bce4ce35b5db",
    body_type: "sedan",
    is_electric: 1,
    model: "F40",
    year: 1998
  }
  @invalid_attrs_body_type %{
    car_brand_id: "abcf229c-be01-46a4-b977-bce4ce35b5db",
    body_type: "aaa",
    is_electric: false,
    model: "F40",
    year: 1998
  }
  @invalid_attrs_year %{
    car_brand_id: "abcf229c-be01-46a4-b977-bce4ce35b5db",
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
               "car_brand_id" => "abcf229c-be01-46a4-b977-bce4ce35b5db",
               "model" => "4000",
               "year" => 2011
             } = json_response(conn, 201)

      result = Schema.get_car_data!(id)

      assert %{
               id: id,
               body_type: "coupe",
               is_electric: true,
               car_brand_id: "abcf229c-be01-46a4-b977-bce4ce35b5db",
               model: "4000",
               year: 2011
             } = result
    end

    test "renders errors when data is invalid is electric", %{conn: conn} do
      conn = post(conn, Routes.car_data_path(conn, :create), @invalid_attrs_is_electric)

      assert %{
               "errors" => %{
                 "invalid" => [
                   %{
                     "entry" => "is_electric",
                     "entry_type" => "json_data_property",
                     "rules" => %{
                       "description" => "is invalid",
                       "params" => "boolean",
                       "rule" => "cast"
                     }
                   }
                 ]
               }
             } = json_response(conn, 422)
    end

    test "renders errors when data is invalid body type", %{conn: conn} do
      conn = post(conn, Routes.car_data_path(conn, :create), @invalid_attrs_body_type)

      assert %{
               "errors" => %{
                 "invalid" => [
                   %{
                     "entry" => "body_type",
                     "entry_type" => "json_data_property",
                     "rules" => %{
                       "description" => "is invalid",
                       "params" => ["sedan", "coupe", "pickup"],
                       "rule" => "inclusion"
                     }
                   }
                 ]
               }
             } = json_response(conn, 422)
    end

    test "renders errors when data is invalid year", %{conn: conn} do
      min_year = Application.get_env(:test_api, TestApi.Schema.CarData)[:car_data_min_year]
      max_year = DateTime.utc_now().year
      message = "is invalid, value must be between range #{min_year} - #{max_year}"
      conn = post(conn, Routes.car_data_path(conn, :create), @invalid_attrs_year)

      assert %{
               "errors" => %{
                 "invalid" => [
                   %{
                     "entry" => "year",
                     "entry_type" => "json_data_property",
                     "rules" => %{
                       "description" => message
                     }
                   }
                 ]
               }
             } = json_response(conn, 422)
    end
  end
end
