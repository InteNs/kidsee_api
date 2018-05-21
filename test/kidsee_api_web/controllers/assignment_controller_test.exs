defmodule KidseeApiWeb.AssignmentControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.AssignmentFactory
  end
  describe "index" do
    test "lists all assignments", %{conn: conn} do
      conn = get(conn, assignment_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders assignment when data is valid", %{conn: conn} do
      conn_create = post conn, assignment_path(conn, :create), build(:jsonapi_assignment)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, assignment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, assignment_path(conn, :create), json_api_params_for(:invalid_assignment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [assignment: insert(:assignment)] end

    test "renders assignment when data is valid", %{conn: conn, assignment: assignment} do
      conn_patch =(patch conn, assignment_path(conn, :update, assignment), build(:jsonapi_assignment))
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, assignment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, assignment: assignment} do
      conn = patch conn, assignment_path(conn, :update, assignment), json_api_params_for(:invalid_assignment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [assignment: insert(:assignment)] end
    test "deletes chosen assignment", %{conn: conn, assignment: assignment} do
      conn_delete = delete conn, assignment_path(conn, :delete, assignment)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, assignment_path(conn, :show, assignment)
      end
    end
  end
end
