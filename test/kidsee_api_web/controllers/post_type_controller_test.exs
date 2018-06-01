defmodule KidseeApiWeb.PostTypeControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.PostTypeFactory
  end
  describe "index" do
    test "lists all post_types", %{conn: conn} do
      conn = get(conn, post_type_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders post_type when data is valid", %{conn: conn} do
      conn_create = post conn, post_type_path(conn, :create), build(:jsonapi_post_type)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, post_type_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, post_type_path(conn, :create), json_api_params_for(:invalid_post_type))
      assert json_response(conn, 422)["errors"] != %{}
    end
end

  describe "update" do
    setup do [post_type: insert(:post_type)] end

    test "renders post_type when data is valid", %{conn: conn, post_type: post_type} do
      conn_patch = patch conn, post_type_path(conn, :update, post_type), build(:jsonapi_post_type)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, post_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, post_type: post_type} do
      conn = patch conn, post_type_path(conn, :update, post_type), json_api_params_for(:invalid_post_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [post_type: insert(:post_type)] end
    test "deletes chosen post_type", %{conn: conn, post_type: post_type} do
      conn_delete = delete conn, post_type_path(conn, :delete, post_type)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, post_type_path(conn, :show, post_type)
      end
    end
  end
end
