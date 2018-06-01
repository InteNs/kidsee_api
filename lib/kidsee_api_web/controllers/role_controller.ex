defmodule KidseeApiWeb.RoleController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Role
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    roles = Role
               |> Repo.all
    render(conn, "index.json-api", data: roles)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %Role{} = role} <- Context.create(Role, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", role_path(conn, :show, role))
      |> render("show.json-api", data: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Context.get!(Role, id)
    render(conn, "index.json-api", data: role)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    role = Context.get!(Role, id)

    with {:ok, %Role{} = role} <- Context.update(role, attrs) do
      render conn, "show.json-api", data: role
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Context.get!(Role, id)
    with {:ok, %Role{}} <- Context.delete(role) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    Map.merge(Role.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:role)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:role)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:role)

    response 201, "created", JsonApi.single(:role)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:role)

    response 200, "OK", JsonApi.single(:role)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
