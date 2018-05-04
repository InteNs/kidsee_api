defmodule KidseeApiWeb.LocationTypeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.LocationType
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    location_types = LocationType
               |> Repo.all
    render(conn, "index.json-api", data: location_types)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %LocationType{} = location_type} <- Context.create(LocationType, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", location_type_path(conn, :show, location_type))
      |> render("show.json-api", data: location_type)
    end
  end

  def show(conn, %{"id" => id}) do
    location_type = Context.get!(LocationType, id)
    render conn, "show.json-api", data: location_type
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    location_type = Context.get!(LocationType, id)

    with {:ok, %LocationType{} = location_type} <- Context.update(location_type, attrs) do
      render conn, "show.json-api", data: location_type
    end
  end

  def delete(conn, %{"id" => id}) do
    location_type = Context.get!(LocationType, id)
    with {:ok, %LocationType{}} <- Context.delete(location_type) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    Map.merge(
      LocationType.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:location_type)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:location_type)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:location_type)

    response 201, "created", JsonApi.single(:locationv)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:location_type)

    response 200, "OK", JsonApi.single(:location_type)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
