defmodule KidseeApiWeb.LocationController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Location
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name rating description address lat lon location_type_id)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    locations = Location
                |> Repo.preload_schema
                |> Location.for_theme(Map.get(params, "theme_id"))
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: locations.entries, opts: [include: location_includes()])
  end

  def create(conn, %{"data" => location_params}) do
    location_params = Params.to_attributes(location_params)
    with {:ok, %Location{id: id}} <- Context.create(Location, location_params) do
      location = Location
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", location_path(conn, :show, location))
      |> render("show.json-api", data: location, opts: [include: location_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    location = Location
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: location, opts: [include: location_includes()])
  end

  def update(conn, %{"id" => id, "data" => location_params}) do
    location_params = Params.to_attributes(location_params)
    location = Location
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Location{} = location} <- Context.update(location, location_params) do
      render(conn, "show.json-api", data: location)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Location
           |> Repo.get!(id)
    with {:ok, %Location{}} <- Context.delete(location) do
      send_resp(conn, :no_content, "")
    end
  end

  def location_includes, do: "location_type"

  def swagger_definitions do
    Map.merge(
      Location.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:location)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:location)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:location)

    response 201, "created", JsonApi.single(:location)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:location)

    response 200, "OK", JsonApi.single(:location)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
