defmodule KidseeApiWeb.LocationControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.LocationFactory
  end
  describe "index" do
    test "lists all locations", %{conn: conn} do
      conn = get(conn, location_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders location when data is valid", %{conn: conn} do
      conn_create = post conn, location_path(conn, :create), build(:jsonapi_location)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, location_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, location_path(conn, :create), json_api_params_for(:invalid_location))
      assert json_response(conn, 422)["errors"] != %{}
    end
end

describe "update" do
  setup do [location: insert(:location)] end

  test "renders location when data is valid", %{conn: conn, location: location} do
    conn_patch =(patch conn, location_path(conn, :update, location), build(:jsonapi_location))
    assert %{"id" => id} = json_response(conn_patch, 200)["data"]

    conn_get = get conn, location_path(conn, :show, id)
    assert json_response(conn_get, 200)
  end

  test "renders errors when data is invalid", %{conn: conn, location: location} do
    conn = patch conn, location_path(conn, :update, location), json_api_params_for(:invalid_location)
    assert json_response(conn, 422)["errors"] != %{}
  end
end

  describe "delete" do
    setup do [location: insert(:location)] end
    test "deletes chosen location", %{conn: conn, location: location} do
      conn_delete = delete conn, location_path(conn, :delete, location)
      assert response(conn_delete, 204)

      #assert_error_sent 404, fn ->
      #  get conn, location_path(conn, :show, location)
      #end
    end
  end
end
