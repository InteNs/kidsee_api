defmodule KidseeApiWeb.CommentController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Comment
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(post_id user_id content_type_id content)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    comments = Comment
               |> Repo.preload_schema
               |> build_query(conn, params)
               |> Repo.paginate(params)
    render(conn, "index.json-api", data: comments.entries, opts: [include: comment_includes()])
  end

  def create(conn, %{"data" => comment_params}) do
    comment_params = Params.to_attributes(comment_params)
    with {:ok, %Comment{id: id}} <- Context.create(Comment, comment_params) do
      comment = Comment
                |> Repo.preload_schema
                |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("show.json-api", data: comment, opts: [include: comment_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comment
              |> Repo.preload_schema
              |> Repo.get!(id)
    render(conn, "show.json-api", data: comment, opts: [include: comment_includes()])
  end

  def update(conn, %{"id" => id, "data" => comment_params}) do
    comment_params = Params.to_attributes(comment_params)
    comment = Comment
              |> Repo.preload_schema
              |> Repo.get!(id)

    with {:ok, %Comment{} = comment} <- Context.update(comment, comment_params) do
      render(conn, "show.json-api", data: comment, opts: [include: comment_includes()])
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comment
              |> Repo.get!(id)
    with {:ok, %Comment{}} <- Context.delete(comment) do
      send_resp(conn, :no_content, "")
    end
  end

  def comment_includes, do: "content_type,user,post"

  def swagger_definitions do
    Map.merge(Comment.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:comment)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:comment)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:comment)

    response 201, "created", JsonApi.single(:comment)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:comment)

    response 200, "OK", JsonApi.single(:comment)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
