defmodule KidseeApiWeb.DiscoveryController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Discovery
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    discoverys = Discovery
                |> Repo.preload_schema
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: discoverys.entries, opts: [include: discovery_includes()])
  end

  def create(conn, %{"data" => discovery_params}) do
    discovery_params = Params.to_attributes(discovery_params)
    with {:ok, %Discovery{id: id}} <- Context.create(Discovery, discovery_params) do
      discovery = Discovery
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("discovery", discovery_path(conn, :show, discovery))
      |> render("show.json-api", data: discovery, opts: [include: discovery_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    discovery = Discovery
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: discovery, opts: [include: discovery_includes()])
  end

  def update(conn, %{"id" => id, "data" => discovery_params}) do
    discovery_params = Params.to_attributes(discovery_params)
    discovery = Discovery
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Discovery{} = discovery} <- Context.update(discovery, discovery_params) do
      render(conn, "show.json-api", data: discovery)
    end
  end

  def delete(conn, %{"id" => id}) do
    discovery = Discovery
           |> Repo.get!(id)
    with {:ok, %Discovery{}} <- Context.delete(discovery) do
      send_resp(conn, :no_content, "")
    end
  end

  def discovery_includes, do: ""

  def swagger_definitions do
    Map.merge(
      Discovery.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:discovery)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:discovery)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:discovery)

    response 201, "created", JsonApi.single(:discovery)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:discovery)

    response 200, "OK", JsonApi.single(:discovery)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
