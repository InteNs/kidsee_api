defmodule KidseeApiWeb.UsersController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Accounts
  alias KidseeApi.Accounts.User
  alias JaSerializer.Params

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json-api", data: users)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %User{} = user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", users_path(conn, :show, user))
      |> render("show.json-api", data: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render conn, "show.json-api", data: user
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
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
