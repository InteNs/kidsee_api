defmodule KidseeApiWeb.DiscoveryControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.DiscoveryFactory
  end
  describe "index" do
    test "lists all discoverys", %{conn: conn} do
      conn = get(conn, discovery_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders discovery when data is valid", %{conn: conn} do
      conn_create = post conn, discovery_path(conn, :create), build(:jsonapi_discovery)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, discovery_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, discovery_path(conn, :create), json_api_params_for(:invalid_discovery))
      assert json_response(conn, 422)["errors"] != %{}
    end
end

describe "update" do
  setup do [discovery: insert(:discovery)] end

  test "renders discovery when data is valid", %{conn: conn, discovery: discovery} do
    conn_patch = patch conn, discovery_path(conn, :update, discovery), build(:jsonapi_discovery)
    assert %{"id" => id} = json_response(conn_patch, 200)["data"]

    conn_get = get conn, discovery_path(conn, :show, id)
    assert json_response(conn_get, 200)
  end

  test "renders errors when data is invalid", %{conn: conn, discovery: discovery} do
    conn = patch conn, discovery_path(conn, :update, discovery), json_api_params_for(:invalid_discovery)
    assert json_response(conn, 422)["errors"] != %{}
  end
end

  describe "delete" do
    setup do [discovery: insert(:discovery)] end
    test "deletes chosen discovery", %{conn: conn, discovery: discovery} do
      conn_delete = delete conn, discovery_path(conn, :delete, discovery)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, discovery_path(conn, :show, discovery)
      end
    end
  end
end
