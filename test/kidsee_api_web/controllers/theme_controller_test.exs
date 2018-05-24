defmodule KidseeApiWeb.ThemeControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.ThemeFactory
  end
  describe "index" do
    test "lists all theme", %{conn: conn} do
      conn = get(conn, theme_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders theme when data is valid", %{conn: conn} do
      conn_create = post conn, theme_path(conn, :create), json_api_params_for(:theme)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, theme_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, theme_path(conn, :create), json_api_params_for(:invalid_theme)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [theme: insert(:theme)] end

    test "renders theme when data is valid", %{conn: conn, theme: theme} do
      conn_patch = patch conn, theme_path(conn, :update, theme), build(:jsonapi_theme)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, theme_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, theme: theme} do
      conn = patch conn, theme_path(conn, :update, theme), json_api_params_for(:invalid_theme)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [theme: insert(:theme)] end
    test "deletes chosen theme", %{conn: conn, theme: theme} do
      conn_delete = delete conn, theme_path(conn, :delete, theme)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, theme_path(conn, :show, theme)
      end
    end
  end
end
