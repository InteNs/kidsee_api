defmodule KidseeApiWeb.RoleControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.RoleFactory
  end
  describe "index" do
    test "lists all roles", %{conn: conn} do
      conn = get(conn, role_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders role when data is valid", %{conn: conn} do
      conn_create = post conn, role_path(conn, :create), build(:jsonapi_role)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, role_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, role_path(conn, :create), json_api_params_for(:invalid_role))
      assert json_response(conn, 422)["errors"] != %{}
    end
end

  describe "update" do
    setup do [role: insert(:role)] end

    test "renders role when data is valid", %{conn: conn, role: role} do
      conn_patch = patch conn, role_path(conn, :update, role), build(:jsonapi_role)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, role_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, role: role} do
      conn = patch conn, role_path(conn, :update, role), json_api_params_for(:invalid_role)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [role: insert(:role)] end
    test "deletes chosen role", %{conn: conn, role: role} do
      conn_delete = delete conn, role_path(conn, :delete, role)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, role_path(conn, :show, role)
      end
    end
  end
end
