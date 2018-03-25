defmodule KidseeApi.Account.TimelineTest do
#  use KidseeApi.DataCase
#
#  alias KidseeApi.Timeline
#
#  describe "posts" do
#    alias KidseeApi.Timeline.Post.Post
#
#    @valid_attrs %{content: "some content", content_type_id: 42, location: "some location", status_id: 42, title: "some title", user_id: 42}
#    @update_attrs %{content: "some updated content", content_type_id: 43, location: "some updated location", status_id: 43, title: "some updated title", user_id: 43}
#    @invalid_attrs %{content: nil, content_type_id: nil, location: nil, status_id: nil, title: nil, user_id: nil}
#
#    def post_fixture(attrs \\ %{}) do
#      {:ok, post} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Timeline.create_post()
#
#      post
#    end
#
#    test "list_posts/0 returns all posts" do
#      post = post_fixture()
#      assert Timeline.list_posts() == [post]
#    end
#
#    test "get_post!/1 returns the post with given id" do
#      post = post_fixture()
#      assert Timeline.get_post!(post.id) == post
#    end
#    test "create_post/1 with valid data creates a post" do
#      assert {:ok, %Post{} = post} = Timeline.create_post(@valid_attrs)
#      assert post.content == "some content"
#      assert post.content_type_id == 42
#      assert post.location == "some location"
#      assert post.status_id == 42
#      assert post.title == "some title"
#      assert post.user_id == 42
#    end
#
#    test "create_post/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(@invalid_attrs)
#    end
#
#    test "update_post/2 with valid data updates the post" do
#      post = post_fixture()
#      assert {:ok, post} = Timeline.update_post(post, @update_attrs)
#      assert %Post{} = post
#      assert post.content == "some updated content"
#      assert post.content_type_id == 43
#      assert post.location == "some updated location"
#      assert post.status_id == 43
#      assert post.title == "some updated title"
#      assert post.user_id == 43
#    end
#
#    test "update_post/2 with invalid data returns error changeset" do
#      post = post_fixture()
#      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(post, @invalid_attrs)
#      assert post == Timeline.get_post!(post.id)
#    end
#
#    test "delete_post/1 deletes the post" do
#      post = post_fixture()
#      assert {:ok, %Post{}} = Timeline.delete_post(post)
#      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(post.id) end
#    end
#
#    test "change_post/1 returns a post changeset" do
#      post = post_fixture()
#      assert %Ecto.Changeset{} = Timeline.change_post(post)
#    end
#  end
end
