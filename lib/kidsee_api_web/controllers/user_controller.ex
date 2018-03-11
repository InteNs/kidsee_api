defmodule KidseeApiWeb.UserController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Accounts
  alias KidseeApi.Accounts.User

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json-api", data: users)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    # Find the user in the database based on the credentials sent with the request
    with %User{} = user <- Accounts.find_user(%{email: email}) do
      # Attempt to authenticate the user
      with {:ok, token, _claims} <- Accounts.authenticate(%{user: user, password: password}) do
        # Render the token
        render conn, "token.json-api", token: token
      end
    end
  end

  def create(conn, %{"data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)
    with {:ok, %User{} = user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json-api", data: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render conn, "show.json-api", data: user
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, attrs) do
      render conn, "show.json-api", data: user
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
