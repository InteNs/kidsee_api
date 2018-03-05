defmodule KidseeApiWeb.UserController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Accounts
  alias KidseeApi.Accounts.User
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password} = params) do
  IO.inspect password
  #text conn, "OK"
    # Find the user in the database based on the credentials sent with the request
    with %User{} = user <- Repo.get_by(User, email: email, password: password) do
      # Attempt to authenticate the user
      with {:ok, token, _claims} <- Accounts.authenticate(%{user: user, password: password}) do
        # Render the token
        render conn, "token.json", token: token
      end
    end
  end

  #def sign_in(conn, _params) do
  #  send_resp(conn, 401, Poison.encode!(%{error: "Incorrect password"}))
  #end

  def sign_out(conn, _params) do
    conn
    |> KidseeApi.Guardian.Plug.sign_out()
    |> send_resp(204, "")
  end
  def show_loggend_in(conn, params) do
    user = KidseeApi.Guardian.Plug.current_resource(conn)

    send_resp(conn, 200, Poison.encode!(%{user: user}))
  end
end
