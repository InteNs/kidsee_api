defmodule KidseeApiWeb.DiscoveryAssignmentControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.DiscoveryAssignmentFactory
  end
  describe "index" do
    test "lists all discovery_assignments", %{conn: conn} do
      conn = get(conn, discovery_assignment_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders discovery_assignment when data is valid", %{conn: conn} do
      conn_create = post conn, discovery_assignment_path(conn, :create), build(:jsonapi_discovery_assignment)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, discovery_assignment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, discovery_assignment_path(conn, :create), json_api_params_for(:invalid_discovery_assignment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [discovery_assignment: insert(:discovery_assignment)] end

    test "renders discovery_assignment when data is valid", %{conn: conn, discovery_assignment: discovery_assignment} do
      conn_patch = patch conn, discovery_assignment_path(conn, :update, discovery_assignment), build(:jsonapi_discovery_assignment)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, discovery_assignment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, discovery_assignment: discovery_assignment} do
      conn = patch conn, discovery_assignment_path(conn, :update, discovery_assignment), json_api_params_for(:invalid_discovery_assignment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [discovery_assignment: insert(:discovery_assignment)] end
    test "deletes chosen discovery_assignment", %{conn: conn, discovery_assignment: discovery_assignment} do
      conn_delete = delete conn, discovery_assignment_path(conn, :delete, discovery_assignment)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, discovery_assignment_path(conn, :show, discovery_assignment)
      end
    end
  end
end
