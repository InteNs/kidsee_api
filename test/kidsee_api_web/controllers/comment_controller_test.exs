defmodule KidseeApiWeb.CommentControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.CommentFactory
  end
  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get(conn, comment_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders comment when data is valid", %{conn: conn} do
      conn_create = post conn, comment_path(conn, :create), build(:jsonapi_comment)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get(conn, comment_path(conn, :show, id))
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = (post conn, comment_path(conn, :create), json_api_params_for(:invalid_comment))
      assert json_response(conn, 422)["errors"] != %{}
    end
end

  describe "update" do
    setup do [comment: insert(:comment)] end

    test "renders comment when data is valid", %{conn: conn, comment: comment} do
      conn_patch =(patch conn, comment_path(conn, :update, comment), build(:jsonapi_comment))
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, comment_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = patch conn, comment_path(conn, :update, comment), json_api_params_for(:invalid_comment)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [comment: insert(:comment)] end
    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn_delete = delete conn, comment_path(conn, :delete, comment)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, comment_path(conn, :show, comment)
      end
    end
  end
end
