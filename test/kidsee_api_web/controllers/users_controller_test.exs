defmodule KidseeApiWeb.UsersControllerTest do
  use KidseeApiWeb.ConnCase do
    use KidseeApi.Factory
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, users_path(conn, :index)
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders user when data is valid", %{conn: conn} do
      conn_create = post conn, users_path(conn, :create), build(:jsonapi_user)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, users_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, users_path(conn, :create), json_api_params_for(:user)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [user: insert(:user)] end

    test "renders user when data is valid", %{conn: conn, user: user} do
      conn_patch = patch conn, users_path(conn, :update, user), build(:jsonapi_user)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, users_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = patch conn, users_path(conn, :update, user), json_api_params_for(:invalid_user)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [user: insert(:user)] end

    test "deletes chosen user", %{conn: conn, user: user} do
      conn_delete = delete conn, users_path(conn, :delete, user)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, users_path(conn, :show, user)
      end
    end
  end
end
