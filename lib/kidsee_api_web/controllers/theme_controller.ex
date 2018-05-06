defmodule KidseeApiWeb.ThemeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Theme
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, params) do
    themes = Theme
            |> Repo.preload_schema
            |> Repo.paginate(params)
    render(conn, "index.json-api", data: themes.entries, opts: [include: theme_includes()])
  end

  def create(conn, %{"data" => theme_params}) do
    theme_params = Params.to_attributes(theme_params)
    with {:ok, %Theme{id: id}} <- Context.create(Theme, theme_params) do
      theme = Theme
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("theme", theme_path(conn, :show, theme))
      |> render("show.json-api", data: theme, opts: [include: theme_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    theme = Theme
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: theme, opts: [include: theme_includes()])
  end

  def update(conn, %{"id" => id, "data" => theme_params}) do
    theme_params = Params.to_attributes(theme_params)
    theme = Theme
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Theme{} = theme} <- Context.update(theme, theme_params) do
      render(conn, "show.json-api", data: theme)
    end
  end

  def delete(conn, %{"id" => id}) do
    theme = Theme
           |> Repo.get!(id)
    with {:ok, %Theme{}} <- Context.delete(theme) do
      send_resp(conn, :no_content, "")
    end
  end

  def theme_includes, do: "locations"

  def swagger_definitions do
    Map.merge(
      Theme.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:theme)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:theme)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:theme)

    response 201, "created", JsonApi.single(:theme)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:theme)

    response 200, "OK", JsonApi.single(:theme)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
