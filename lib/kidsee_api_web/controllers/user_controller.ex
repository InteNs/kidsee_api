defmodule KidseeApiWeb.UserController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.User
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(birthdate postal_code email school username, inserted_at)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    users = User
                |> Repo.preload_schema
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: users.entries, opts: [include: user_includes()])
  end

  def create(conn, %{"data" => user_params}) do
    user_params = Params.to_attributes(user_params)
    with {:ok, %User{id: id}} <- Context.create(User, user_params) do
      user = User
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("user", location_path(conn, :show, user))
      |> render("show.json-api", data: user, opts: [include: user_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    user = User
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: user, opts: [include: user_includes()])
  end

  def update(conn, %{"id" => id, "data" => user_params}) do
    user_params = Params.to_attributes(user_params)
    user = User
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %User{} = user} <- Context.update(user, user_params) do
      render(conn, "show.json-api", data: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = User
           |> Repo.get!(id)
    with {:ok, %User{}} <- Context.delete(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def user_includes, do: "role"

  def swagger_definitions do
    Map.merge(User.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:user)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:user)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:user)

    response 201, "created", JsonApi.single(:user)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:user)

    response 200, "OK", JsonApi.single(:user)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
