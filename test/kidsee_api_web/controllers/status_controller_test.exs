defmodule KidseeApiWeb.StatusControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.StatusFactory
  end
  describe "index" do
    test "lists all statusus", %{conn: conn} do
      conn = get(conn, status_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders status when data is valid", %{conn: conn} do
      conn_create = post conn, status_path(conn, :create), build(:jsonapi_status)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, status_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, status_path(conn, :create), json_api_params_for(:invalid_status))
      assert json_response(conn, 422)["errors"] != %{}
    end
end

  describe "update" do
    setup do [status: insert(:status)] end

    test "renders status when data is valid", %{conn: conn, status: status} do
      conn_patch = patch conn, status_path(conn, :update, status), build(:jsonapi_status)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, status_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, status: status} do
      conn = patch conn, status_path(conn, :update, status), json_api_params_for(:invalid_status)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [status: insert(:status)] end
    test "deletes chosen status", %{conn: conn, status: status} do
      conn_delete = delete conn, status_path(conn, :delete, status)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, status_path(conn, :show, status)
      end
    end
  end
end
