defmodule KidseeApiWeb.PostTypeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.PostType
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    post_types = PostType
               |> Repo.all
    render(conn, "index.json-api", data: post_types)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %PostType{} = post_type} <- Context.create(PostType, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_type_path(conn, :show, post_type))
      |> render("show.json-api", data: post_type)
    end
  end

  def show(conn, %{"id" => id}) do
    post_type = Context.get!(PostType, id)
    render(conn, "index.json-api", data: post_type)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    post_type = Context.get!(PostType, id)

    with {:ok, %PostType{} = post_type} <- Context.update(post_type, attrs) do
      render conn, "show.json-api", data: post_type
    end
  end

  def delete(conn, %{"id" => id}) do
    post_type = Context.get!(PostType, id)
    with {:ok, %PostType{}} <- Context.delete(post_type) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    Map.merge(PostType.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:post_type)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:post_type)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:post_type)

    response 201, "created", JsonApi.single(:post_type)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:post_type)

    response 200, "OK", JsonApi.single(:post_type)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
