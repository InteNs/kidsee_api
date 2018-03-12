defmodule KidseeApiWeb.TokenControllerTest do
  use KidseeApiWeb.ConnCase do
    use KidseeApi.Factory
  end

  describe "create" do
    setup do [user: insert(:user)] end

    test "renders a token when the email and password are valid", %{conn: conn, user: user} do
      login = %{email: user.email, password: "test123"}
      conn = post conn, token_path(conn, :create), login

      assert %{"token" => token} = json_response(conn, 200)["meta"]
      assert {:ok, _claims} = KidseeApiWeb.Guardian.decode_and_verify(token)
    end

    test "renders a token when the username and password are valid", %{conn: conn, user: user} do
      login = %{username: user.username, password: "test123"}
      conn = post conn, token_path(conn, :create), login

      assert %{"token" => token} = json_response(conn, 200)["meta"]
      assert {:ok, _claims} = KidseeApiWeb.Guardian.decode_and_verify(token)
    end

    test "renders not found if the login was not valid", %{conn: conn} do
      assert_error_sent 404, fn ->
        post conn, token_path(conn, :create), %{email: "bla", password: "bla"}
      end
    end

    test "renders errors if params are missing", %{conn: conn} do
      conn = post conn, token_path(conn, :create), %{}
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
