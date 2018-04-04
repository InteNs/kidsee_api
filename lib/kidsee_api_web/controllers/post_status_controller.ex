defmodule KidseeApiWeb.PostStatusController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Timeline
  alias KidseeApi.Timeline.Post.PostStatus
  alias KidseeApi.Repo
  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    post_statuses = PostStatus
               |> Repo.all
    render(conn, "index.json-api", data: post_statuses)
  end

  def create(conn, %{"post_status" => post_status_params}) do
    #with {:ok, %ContentType{} = post_status} <- Timeline.create_post_status(post_status_params) do
    #  conn
    #  |> put_status(:created)
    #  |> put_resp_header("location", post_status_path(conn, :show, post_status))
    #  |> render("show.json-api", post_status: post_status)
    #end
  end

  def show(conn, %{"id" => id}) do
    post_status = Timeline.get_post_status!(id)
    render(conn, "index.json-api", data: post_status)
  end

  def update(conn, %{"id" => id, "post_status" => post_status_params}) do
   # post_status = Timeline.get_post_status!(id)
#
   # with {:ok, %ContentType{} = post_status} <- Timeline.update_post_status(post_status, post_status_params) do
   #   render(conn, "show.json-api", post_status: post_status)
   # end
  end

  def delete(conn, %{"id" => id}) do
    #post_status = Timeline.get_post_status!(id)
    #with {:ok, %ContentType{}} <- Timeline.delete_post_status(post_status) do
    #  send_resp(conn, :no_content, "")
    #end
  end
end
