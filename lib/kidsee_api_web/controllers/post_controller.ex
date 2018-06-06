defmodule KidseeApiWeb.PostController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Post
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(content title status_id content_type_id user_id location_id post_type_id)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    posts = Post
            |> Repo.preload_schema
            |> Post.for_theme(Map.get(params, "theme_id"))
            |> build_query(conn, params)
            |> Repo.paginate(params)
    render(conn, "index.json-api", data: posts.entries, opts: [include: post_includes()])
  end

  def create(conn, %{"data" => post_params}) do
    post_params = Params.to_attributes(post_params)
    with {:ok, %Post{id: id}} <- Context.create(Post, post_params) do
      post = Post
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json-api", data: post, opts: [include: post_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    post = Post
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: post, opts: [include: post_includes()])
  end

  def update(conn, %{"id" => id, "data" => post_params}) do
    post_params = Params.to_attributes(post_params)
    post = Post
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Post{} = post} <- Context.update(post, post_params) do
      render(conn, "show.json-api", data: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Post
           |> Repo.get!(id)
    with {:ok, %Post{}} <- Context.delete(post) do
      send_resp(conn, :no_content, "")
    end
  end

  def post_includes, do: "content_type,user,status,comments,location,post_type"

  def swagger_definitions do
    Map.merge(
      Post.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:post)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:post)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:post)

    response 201, "created", JsonApi.single(:post)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:post)

    response 200, "OK", JsonApi.single(:post)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
