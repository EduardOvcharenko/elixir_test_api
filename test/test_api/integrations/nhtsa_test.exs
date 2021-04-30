defmodule TestApi.Integrations.NhatsaTest do
  @moduledoc false

  import Mox
  use TestApiWeb.ConnCase

  alias TestApi.Integrations.Nhtsa

  describe "get_brand_list" do
    test "should return array" do
      expect(TestApi.Nhtsa.ClientMock, :get_brands, fn ->
        ["ASTON MARTIN"]
      end)

      assert ["ASTON MARTIN"] = Nhtsa.get_brand_list()
    end
  end
end
