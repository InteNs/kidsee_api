defmodule KidseeApiWeb.StatusController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Timeline
  alias KidseeApi.Timeline.Post.Status
  alias KidseeApi.Repo
  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    statuses = Status
               |> Repo.all
    render(conn, "index.json-api", data: statuses)
  end

  def create(conn, %{"status" => status_params}) do
    #with {:ok, %ContentType{} = status} <- Timeline.create_status(status_params) do
    #  conn
    #  |> put_status(:created)
    #  |> put_resp_header("location", status_path(conn, :show, status))
    #  |> render("show.json-api", status: status)
    #end
  end

  def show(conn, %{"id" => id}) do
    status = Timeline.get_status!(id)
    render(conn, "index.json-api", data: status)
  end

  def update(conn, %{"id" => id, "status" => status_params}) do
   # status = Timeline.get_status!(id)
#
   # with {:ok, %ContentType{} = status} <- Timeline.update_status(status, status_params) do
   #   render(conn, "show.json-api", status: status)
   # end
  end

  def delete(conn, %{"id" => id}) do
    #status = Timeline.get_status!(id)
    #with {:ok, %ContentType{}} <- Timeline.delete_status(status) do
    #  send_resp(conn, :no_content, "")
    #end
  end
end
