defmodule KidseeApi.AccountsTest do
  use KidseeApi.DataCase

  alias KidseeApi.Accounts

  describe "users" do
    alias KidseeApi.Accounts.User

    @valid_attrs %{avatar: "some avatar", birthdate: ~D[2010-04-17], postal_code: "some post code", email: "some email", password: "some password", school: "some school", username: "some username"}
    @update_attrs %{avatar: "some updated avatar", birthdate: ~D[2011-05-18], postal_code: "some updated post code", email: "some updated email", password: "some updated password", school: "some updated school", username: "some updated username"}
    @invalid_attrs %{avatar: nil, birthdate: nil, postal_code: nil, email: nil, password: nil, school: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.birthdate == ~D[2010-04-17]
      assert user.postal_code == "some post code"
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.school == "some school"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.avatar == "some updated avatar"
      assert user.birthdate == ~D[2011-05-18]
      assert user.postal_code == "some updated post code"
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.school == "some updated school"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
