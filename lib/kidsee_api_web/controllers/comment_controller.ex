defmodule KidseeApiWeb.CommentController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Timeline
  alias KidseeApi.Timeline.Post.Comment
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, params) do
    comments = Comment
               |> Repo.preload_schema
               |> Repo.paginate(params)
    render(conn, "index.json-api", data: comments.entries, opts: [include: comment_includes()])
  end

  def create(conn, %{"data" => comment_params}) do
    comment_params = Params.to_attributes(comment_params)
    with {:ok, %Comment{id: id}} <- Timeline.create_comment(comment_params) do
      comment = Comment
                |> Repo.preload_schema
                |> Repo.get(id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("show.json-api", data: comment, opts: [include: comment_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comment
              |> Repo.preload_schema
              |> Repo.get(id)
    render(conn, "show.json-api", data: comment, opts: [include: comment_includes()])
  end

  def update(conn, %{"id" => id, "data" => comment_params}) do
    comment_params = Params.to_attributes(comment_params)
    comment = Comment
              |> Repo.preload_schema
              |> Repo.get(id)

    with {:ok, %Comment{} = comment} <- Timeline.update_comment(comment, comment_params) do
      render(conn, "show.json-api", data: comment, opts: [include: comment_includes()])
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comment
              |> Repo.get(id)
    with {:ok, %Comment{}} <- Timeline.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end

  def comment_includes, do: "content_type,user,post"
end
