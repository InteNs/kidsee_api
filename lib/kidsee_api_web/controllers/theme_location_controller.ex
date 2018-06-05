defmodule KidseeApiWeb.ThemeLocationController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.ThemeLocation
  alias JaSerializer.Params
  alias KidseeApi.Repo
  
  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(theme_id location_id)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    theme_locations = ThemeLocation
            |> Repo.preload_schema
            |> build_query(conn, params)
            |> Repo.paginate(params)
    render(conn, "index.json-api", data: theme_locations.entries)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %ThemeLocation{id: id}} <- Context.create(ThemeLocation, attrs) do
      theme_location = ThemeLocation
                       |> Repo.preload_schema
                       |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", theme_location_path(conn, :show, theme_location))
      |> render("show.json-api", data: theme_location)
    end
  end

  def show(conn, %{"id" => id}) do
    theme_location = ThemeLocation
                     |> Repo.preload_schema
                     |> Repo.get!(id)

    render conn, "show.json-api", data: theme_location
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    theme_location = ThemeLocation
                     |> Repo.preload_schema
                     |> Repo.get!(id)

    with {:ok, %ThemeLocation{} = theme_location} <- Context.update(theme_location, attrs) do
      render conn, "show.json-api", data: theme_location
    end
  end

  def delete(conn, %{"id" => id}) do
    theme_location = Context.get!(ThemeLocation, id)
    with {:ok, %ThemeLocation{}} <- Context.delete(theme_location) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    Map.merge(ThemeLocation.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:theme_location)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:theme_location)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:user)

    response 201, "created", JsonApi.single(:theme_location)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:theme_location)

    response 200, "OK", JsonApi.single(:theme_location)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
