defmodule KidseeApiWeb.PostControllerTest do
  #use KidseeApiWeb.ConnCase
#
  #alias KidseeApi.Timeline
  #alias KidseeApi.Timeline.Post.Post
#
  #@create_attrs %{content: "some content", content_type_id: 42, location: "some location", status_id: 42, title: "some title", user_id: 42}
  #@update_attrs %{content: "some updated content", content_type_id: 43, location: "some updated location", status_id: 43, title: "some updated title", user_id: 43}
  #@invalid_attrs %{content: nil, content_type_id: nil, location: nil, status_id: nil, title: nil, user_id: nil}
#
  #def fixture(:post) do
  #  {:ok, post} = Timeline.create_post(@create_attrs)
  #  post
  #end
#
  #setup %{conn: conn} do
  #  {:ok, conn: put_req_header(conn, "accept", "application/json-api")}
  #end
#
  #describe "index" do
  #  test "lists all posts", %{conn: conn} do
  #    conn = get conn, post_path(conn, :index)
  #    assert json_response(conn, 200)["data"] == []
  #  end
  #end
  #describe "create post" do
  #  test "renders post when data is valid", %{conn: conn} do
  #    conn = post conn, post_path(conn, :create), post: @create_attrs
  #    assert %{"id" => id} = json_response(conn, 201)["data"]
#
  #    conn = get conn, post_path(conn, :show, id)
  #    assert json_response(conn, 200)["data"] == %{
  #      "id" => id,
  #      "content" => "some content",
  #      "content_type_id" => 42,
  #      "location" => "some location",
  #      "status_id" => 42,
  #      "title" => "some title",
  #      "user_id" => 42}
  #  end
#
  #  test "renders errors when data is invalid", %{conn: conn} do
  #    conn = post conn, post_path(conn, :create), post: @invalid_attrs
  #    assert json_response(conn, 422)["errors"] != %{}
  #  end
  #end
#
  #describe "update post" do
  #  setup [:create_post]
#
  #  test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
  #    conn = put conn, post_path(conn, :update, post), post: @update_attrs
  #    assert %{"id" => ^id} = json_response(conn, 200)["data"]
#
  #    conn = get conn, post_path(conn, :show, id)
  #    assert json_response(conn, 200)["data"] == %{
  #      "id" => id,
  #      "content" => "some updated content",
  #      "content_type_id" => 43,
  #      "location" => "some updated location",
  #      "status_id" => 43,
  #      "title" => "some updated title",
  #      "user_id" => 43}
  #  end
#
  #  test "renders errors when data is invalid", %{conn: conn, post: post} do
  #    conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
  #    assert json_response(conn, 422)["errors"] != %{}
  #  end
  #end
  #describe "delete post" do
  #  setup [:create_post]
#
  #  test "deletes chosen post", %{conn: conn, post: post} do
  #    conn = delete conn, post_path(conn, :delete, post)
  #    assert response(conn, 204)
  #    assert_error_sent 404, fn ->
  #      get conn, post_path(conn, :show, post)
  #    end
  #  end
  #end
#
  #defp create_post(_) do
  #  post = fixture(:post)
  #  {:ok, post: post}
  #end
end
