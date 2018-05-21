defmodule KidseeApiWeb.AssignmentController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Assignment
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name rating description address lat lon assignment_type_id)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    assignments = Assignment
                |> Repo.preload_schema
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: assignments.entries, opts: [include: assignment_includes()])
  end

  def create(conn, %{"data" => assignment_params}) do
    assignment_params = Params.to_attributes(assignment_params)
    with {:ok, %Assignment{id: id}} <- Context.create(Assignment, assignment_params) do
      assignment = Assignment
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("assignment", assignment_path(conn, :show, assignment))
      |> render("show.json-api", data: assignment, opts: [include: assignment_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    assignment = Assignment
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: assignment, opts: [include: assignment_includes()])
  end

  def update(conn, %{"id" => id, "data" => assignment_params}) do
    assignment_params = Params.to_attributes(assignment_params)
    assignment = Assignment
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Assignment{} = assignment} <- Context.update(assignment, assignment_params) do
      render(conn, "show.json-api", data: assignment)
    end
  end

  def delete(conn, %{"id" => id}) do
    assignment = Assignment
           |> Repo.get!(id)
    with {:ok, %Assignment{}} <- Context.delete(assignment) do
      send_resp(conn, :no_content, "")
    end
  end

  def assignment_includes, do: "assignment_type, location"

  def swagger_definitions do
    Map.merge(
      Assignment.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:assignment)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:assignment)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:assignment)

    response 201, "created", JsonApi.single(:assignment)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:assignment)

    response 200, "OK", JsonApi.single(:assignment)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
