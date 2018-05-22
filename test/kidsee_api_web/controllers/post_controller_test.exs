defmodule KidseeApiWeb.PostControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.PostFactory
  end
  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, post_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders post when data is valid", %{conn: conn} do
      conn_create = post conn, post_path(conn, :create), build(:jsonapi_post)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, post_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, post_path(conn, :create), json_api_params_for(:invalid_post))
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [post: insert(:post)] end

    test "renders post when data is valid", %{conn: conn, post: post} do
      conn_patch = patch conn, post_path(conn, :update, post), build(:jsonapi_post)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, post_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = patch conn, post_path(conn, :update, post), json_api_params_for(:invalid_post)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [post: insert(:post)] end
    test "deletes chosen post", %{conn: conn, post: post} do
      conn_delete = delete conn, post_path(conn, :delete, post)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, post_path(conn, :show, post)
      end
    end
  end
end
