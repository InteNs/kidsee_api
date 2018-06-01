defmodule KidseeApiWeb.UserAssignmentControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.UserAssignmentFactory
  end
  describe "index" do
    test "lists all user_assignments", %{conn: conn} do
      conn = get(conn, user_assignment_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders user_assignment when data is valid", %{conn: conn} do
      conn_create = post conn, user_assignment_path(conn, :create), build(:jsonapi_user_assignment)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, user_assignment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_assignment_path(conn, :create), json_api_params_for(:invalid_user_assignment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [user_assignment: insert(:user_assignment)] end

    test "renders user_assignment when data is valid", %{conn: conn, user_assignment: user_assignment} do
      conn_patch = patch conn, user_assignment_path(conn, :update, user_assignment), build(:jsonapi_user_assignment)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, user_assignment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user_assignment: user_assignment} do
      conn = patch conn, user_assignment_path(conn, :update, user_assignment), json_api_params_for(:invalid_user_assignment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [user_assignment: insert(:user_assignment)] end
    test "deletes chosen user_assignment", %{conn: conn, user_assignment: user_assignment} do
      conn_delete = delete conn, user_assignment_path(conn, :delete, user_assignment)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, user_assignment_path(conn, :show, user_assignment)
      end
    end
  end
end
