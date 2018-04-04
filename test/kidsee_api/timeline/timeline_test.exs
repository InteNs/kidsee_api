defmodule KidseeApi.TimelineTest do
#  use KidseeApi.DataCase
#
#  alias KidseeApi.Timeline
#
#  describe "comments" do
#    alias KidseeApi.Timeline.Post.Comment
#
#    @valid_attrs %{}
#    @update_attrs %{}
#    @invalid_attrs %{}
#
#    def comment_fixture(attrs \\ %{}) do
#      {:ok, comment} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Timeline.create_comment()
#
#      comment
#    end
#
#    test "list_comments/0 returns all comments" do
#      comment = comment_fixture()
#      assert Timeline.list_comments() == [comment]
#    end
#
#    test "get_comment!/1 returns the comment with given id" do
#      comment = comment_fixture()
#      assert Timeline.get_comment!(comment.id) == comment
#    end
#
#    test "create_comment/1 with valid data creates a comment" do
#      assert {:ok, %Comment{} = comment} = Timeline.create_comment(@valid_attrs)
#    end
#
#    test "create_comment/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Timeline.create_comment(@invalid_attrs)
#    end
#
#    test "update_comment/2 with valid data updates the comment" do
#      comment = comment_fixture()
#      assert {:ok, comment} = Timeline.update_comment(comment, @update_attrs)
#      assert %Comment{} = comment
#    end
#
#    test "update_comment/2 with invalid data returns error changeset" do
#      comment = comment_fixture()
#      assert {:error, %Ecto.Changeset{}} = Timeline.update_comment(comment, @invalid_attrs)
#      assert comment == Timeline.get_comment!(comment.id)
#    end
#
#    test "delete_comment/1 deletes the comment" do
#      comment = comment_fixture()
#      assert {:ok, %Comment{}} = Timeline.delete_comment(comment)
#      assert_raise Ecto.NoResultsError, fn -> Timeline.get_comment!(comment.id) end
#    end
#
#    test "change_comment/1 returns a comment changeset" do
#      comment = comment_fixture()
#      assert %Ecto.Changeset{} = Timeline.change_comment(comment)
#    end
#  end
#
#  describe "content_types" do
#    alias KidseeApi.Timeline.ContentType
#
#    @valid_attrs %{desciption: "some desciption", name: "some name"}
#    @update_attrs %{desciption: "some updated desciption", name: "some updated name"}
#    @invalid_attrs %{desciption: nil, name: nil}
#
#    def content_type_fixture(attrs \\ %{}) do
#      {:ok, content_type} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Timeline.create_content_type()
#
#      content_type
#    end
#
#    test "list_content_types/0 returns all content_types" do
#      content_type = content_type_fixture()
#      assert Timeline.list_content_types() == [content_type]
#    end
#
#    test "get_content_type!/1 returns the content_type with given id" do
#      content_type = content_type_fixture()
#      assert Timeline.get_content_type!(content_type.id) == content_type
#    end
#
#    test "create_content_type/1 with valid data creates a content_type" do
#      assert {:ok, %ContentType{} = content_type} = Timeline.create_content_type(@valid_attrs)
#      assert content_type.desciption == "some desciption"
#      assert content_type.name == "some name"
#    end
#
#    test "create_content_type/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Timeline.create_content_type(@invalid_attrs)
#    end
#
#    test "update_content_type/2 with valid data updates the content_type" do
#      content_type = content_type_fixture()
#      assert {:ok, content_type} = Timeline.update_content_type(content_type, @update_attrs)
#      assert %ContentType{} = content_type
#      assert content_type.desciption == "some updated desciption"
#      assert content_type.name == "some updated name"
#    end
#
#    test "update_content_type/2 with invalid data returns error changeset" do
#      content_type = content_type_fixture()
#      assert {:error, %Ecto.Changeset{}} = Timeline.update_content_type(content_type, @invalid_attrs)
#      assert content_type == Timeline.get_content_type!(content_type.id)
#    end
#
#    test "delete_content_type/1 deletes the content_type" do
#      content_type = content_type_fixture()
#      assert {:ok, %ContentType{}} = Timeline.delete_content_type(content_type)
#      assert_raise Ecto.NoResultsError, fn -> Timeline.get_content_type!(content_type.id) end
#    end
#
#    test "change_content_type/1 returns a content_type changeset" do
#      content_type = content_type_fixture()
#      assert %Ecto.Changeset{} = Timeline.change_content_type(content_type)
#    end
#  end
end
