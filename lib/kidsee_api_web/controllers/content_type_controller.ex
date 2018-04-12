defmodule KidseeApiWeb.ContentTypeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schema.ContentType
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    content_types = ContentType
               |> Repo.all
    render(conn, "index.json-api", data: content_types)
  end

  def create(conn, %{"content_type" => content_type_params}) do
    #with {:ok, %ContentType{} = content_type} <- Timeline.create_content_type(content_type_params) do
    #  conn
    #  |> put_status(:created)
    #  |> put_resp_header("location", content_type_path(conn, :show, content_type))
    #  |> render("show.json-api", content_type: content_type)
    #end
  end

  def show(conn, %{"id" => id}) do
    content_type = Context.get!(ContentType, id)
    render(conn, "index.json-api", data: content_type)
  end

  def update(conn, %{"id" => id, "content_type" => content_type_params}) do
   # content_type = Timeline.get_content_type!(id)
#
   # with {:ok, %ContentType{} = content_type} <- Timeline.update_content_type(content_type, content_type_params) do
   #   render(conn, "show.json-api", content_type: content_type)
   # end
  end

  def delete(conn, %{"id" => id}) do
    #content_type = Timeline.get_content_type!(id)
    #with {:ok, %ContentType{}} <- Timeline.delete_content_type(content_type) do
    #  send_resp(conn, :no_content, "")
    #end
  end
end
