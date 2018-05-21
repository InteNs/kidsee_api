defmodule KidseeApiWeb.AssignmentTypeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.AssignmentType
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name description)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    assignment_types = AssignmentType
                    |> build_query(conn, params)
                    |> Repo.all
    render(conn, "index.json-api", data: assignment_types)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %AssignmentType{} = assignment_type} <- Context.create(AssignmentType, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", assignment_type_path(conn, :show, assignment_type))
      |> render("show.json-api", data: assignment_type)
    end
  end

  def show(conn, %{"id" => id}) do
    assignment_type = Context.get!(AssignmentType, id)
    render conn, "show.json-api", data: assignment_type
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    assignment_type = Context.get!(AssignmentType, id)

    with {:ok, %AssignmentType{} = assignment_type} <- Context.update(assignment_type, attrs) do
      render conn, "show.json-api", data: assignment_type
    end
  end

  def delete(conn, %{"id" => id}) do
    assignment_type = Context.get!(AssignmentType, id)
    with {:ok, %AssignmentType{}} <- Context.delete(assignment_type) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    Map.merge(AssignmentType.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:assignment_type)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:assignment_type)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:assignment_type)

    response 201, "created", JsonApi.single(:assignment_type)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:assignment_type)

    response 200, "OK", JsonApi.single(:content_type)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
