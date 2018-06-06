defmodule KidseeApiWeb.DiscoveryAssignmentController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.DiscoveryAssignment
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name answer_id correct_answer)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    discovery_assignment = DiscoveryAssignment
                |> Repo.preload_schema
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: discovery_assignment.entries, opts: [include: answer_includes()])
  end

  def create(conn, %{"data" => params}) do
    params = Params.to_attributes(params)
    with {:ok, %DiscoveryAssignment{id: id}} <- Context.create(DiscoveryAssignment, params) do
      discovery_assignment = DiscoveryAssignment
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("discovery_assignment", discovery_assignment_path(conn, :show, discovery_assignment))
      |> render("show.json-api", data: discovery_assignment, opts: [include: answer_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    discovery_assignment = DiscoveryAssignment
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: discovery_assignment, opts: [include: answer_includes()])
  end

  def update(conn, %{"id" => id, "data" => params}) do
    params = Params.to_attributes(params)
    discovery_assignment = DiscoveryAssignment
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %DiscoveryAssignment{} = discovery_assignment} <- Context.update(discovery_assignment, params) do
      render(conn, "show.json-api", data: discovery_assignment)
    end
  end

  def delete(conn, %{"id" => id}) do
    discovery_assignment = DiscoveryAssignment
           |> Repo.get!(id)
    with {:ok, %DiscoveryAssignment{}} <- Context.delete(discovery_assignment) do
      send_resp(conn, :no_content, "")
    end
  end

  def answer_includes, do: "assignment,discovery"

  def swagger_definitions do
    Map.merge(
      DiscoveryAssignment.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:discovery_assignment)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:discovery_assignment)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:discovery_assignment)

    response 201, "created", JsonApi.single(:discovery_assignment)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:discovery_assignment)

    response 200, "OK", JsonApi.single(:discovery_assignment)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
