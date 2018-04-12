defmodule KidseeApiWeb.UserController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.User
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, params) do
    users = User
            |> Repo.paginate(params)
    render(conn, "index.json-api", data: users.entries)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %User{} = user} <- Context.create(User, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json-api", data: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Context.get!(User, id)
    render conn, "show.json-api", data: user
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    user = Context.get!(User, id)

    with {:ok, %User{} = user} <- Context.update(user, attrs) do
      render conn, "show.json-api", data: user
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Context.get!(User, id)
    with {:ok, %User{}} <- Context.delete(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
