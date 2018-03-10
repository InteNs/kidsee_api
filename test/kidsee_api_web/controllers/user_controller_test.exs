defmodule KidseeApiWeb.UserControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.Factory
  end

  describe "delete" do
    setup do [user: insert(:user)] end

    test "deletes chosen user", %{conn: conn, user: user} do
      conn_delete = delete conn, user_path(conn, :delete, user)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, user)
      end
    end
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders user when data is valid", %{conn: conn} do
      conn_create = post conn, user_path(conn, :create, user: string_params_for(:user))
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, user_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create, user: string_params_for(:invalid_user))
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [user: insert(:user)] end

    test "renders user when data is valid", %{conn: conn, user: user} do
      conn_patch = patch conn, user_path(conn, :update, user), user: string_params_for(:user)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, user_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = patch conn, user_path(conn, :update, user), user: %{"email" => nil}
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
