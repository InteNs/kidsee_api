defmodule KidseeApiWeb.AssignmentTypeControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.AssignmentTypeFactory
  end
  describe "index" do
    test "lists all assignment_types", %{conn: conn} do
      conn = get(conn, assignment_type_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders assignment_type when data is valid", %{conn: conn} do
      conn_create = post conn, assignment_type_path(conn, :create), build(:jsonapi_assignment_type)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, assignment_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, assignment_type_path(conn, :create), json_api_params_for(:invalid_assignment_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [assignment_type: insert(:assignment_type)] end

    test "renders assignment_type when data is valid", %{conn: conn, assignment_type: assignment_type} do
      conn_patch = patch conn, assignment_type_path(conn, :update, assignment_type), build(:jsonapi_assignment_type)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, assignment_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, assignment_type: assignment_type} do
      conn = patch conn, assignment_type_path(conn, :update, assignment_type), json_api_params_for(:invalid_assignment_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [assignment_type: insert(:assignment_type)] end
    test "deletes chosen assignment_type", %{conn: conn, assignment_type: assignment_type} do
      conn_delete = delete conn, assignment_type_path(conn, :delete, assignment_type)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, assignment_type_path(conn, :show, assignment_type)
      end
    end
  end
end
