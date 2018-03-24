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
end
