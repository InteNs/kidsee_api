defmodule KidseeApiWeb.CommentController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Timeline
  alias KidseeApi.Timeline.Post.Comment
  alias JaSerializer.Params

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    comments = Timeline.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"data" => comment_params}) do
    comment_params = Params.to_attributes(comment_params)
    with {:ok, %Comment{} = comment} <- Timeline.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Timeline.get_comment!(id) |> IO.inspect
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "data" => comment_params}) do
    comment_params = Params.to_attributes(comment_params)
    comment = Timeline.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Timeline.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Timeline.get_comment!(id)
    with {:ok, %Comment{}} <- Timeline.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
