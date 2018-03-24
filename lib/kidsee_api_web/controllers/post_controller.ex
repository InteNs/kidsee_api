defmodule KidseeApiWeb.PostController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Timeline
  alias KidseeApi.Timeline.Post.Post
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    posts = Timeline.list_posts()
    render(conn, "index.json-api", posts: posts)
  end

  def create(conn, %{"data" => post_params}) do
    post_params = Params.to_attributes(post_params)
    with {:ok, %Post{} = post} <- Timeline.create_post(post_params) do
      post = Repo.preload(post,[:content_type, :user, :status, :comments])
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Timeline.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "data" => post_params}) do
    post_params = Params.to_attributes(post_params)
    post = Timeline.get_post!(id)

    with {:ok, %Post{} = post} <- Timeline.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Timeline.get_post!(id)
    with {:ok, %Post{}} <- Timeline.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
