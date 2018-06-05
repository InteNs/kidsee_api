defmodule ThemeLocationControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.ThemeLocationFactory
  end
  
  describe "index" do
    test "lists all theme_locations", %{conn: conn} do
      conn = get conn, theme_location_path(conn, :index)
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders theme_location when data is valid", %{conn: conn} do
      conn_create = post conn, theme_location_path(conn, :create), build(:jsonapi_theme_location)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, theme_location_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, theme_location_path(conn, :create), json_api_params_for(:invalid_theme_location)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [theme_location: insert(:theme_location)] end

    test "renders theme_location when data is valid", %{conn: conn, theme_location: theme_location} do
      conn_patch = patch conn, theme_location_path(conn, :update, theme_location), build(:jsonapi_theme_location)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, theme_location_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, theme_location: theme_location} do
      conn = patch conn, theme_location_path(conn, :update, theme_location), json_api_params_for(:invalid_theme_location)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [theme_location: insert(:theme_location)] end

    test "deletes chosen theme_location", %{conn: conn, theme_location: theme_location} do
      conn_delete = delete conn, theme_location_path(conn, :delete, theme_location)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, theme_location_path(conn, :show, theme_location)
      end
    end
  end
end
