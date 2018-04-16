defmodule KidseeApiWeb.PostController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Post
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, params) do
    posts = Post
            |> Repo.preload_schema
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

  def post_includes, do: "content_type,user,status,comments"
end
