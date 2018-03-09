defmodule KidseeApiWeb.UserControllerTest do
  use KidseeApiWeb.ConnCase

  alias KidseeApi.Accounts
  alias KidseeApi.Accounts.User

  @create_attrs %{avatar: "some avatar", birthdate: ~D[2010-04-17], city: "some city", email: "some email", password: "some password", school: "some school", username: "some username"}
  @update_attrs %{avatar: "some updated avatar", birthdate: ~D[2011-05-18], city: "some updated city", email: "some updated email", password: "some updated password", school: "some updated school", username: "some updated username"}
  @invalid_attrs %{avatar: nil, birthdate: nil, city: nil, email: nil, password: nil, school: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, user_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "avatar" => "some avatar",
        "birthdate" => ~D[2010-04-17],
        "city" => "some city",
        "email" => "some email",
        "password" => "some password",
        "school" => "some school",
        "username" => "some username"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put conn, user_path(conn, :update, user), user: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, user_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "avatar" => "some updated avatar",
        "birthdate" => ~D[2011-05-18],
        "city" => "some updated city",
        "email" => "some updated email",
        "password" => "some updated password",
        "school" => "some updated school",
        "username" => "some updated username"}
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, user_path(conn, :delete, user)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, user)
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
