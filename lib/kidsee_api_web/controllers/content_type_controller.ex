defmodule KidseeApiWeb.ContentTypeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.ContentType
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    content_types = ContentType
               |> Repo.all
    render(conn, "index.json-api", data: content_types)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %ContentType{} = content_type} <- Context.create(ContentType, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", content_type_path(conn, :show, content_type))
      |> render("show.json-api", data: content_type)
    end
  end

  def show(conn, %{"id" => id}) do
    content_type = Context.get!(ContentType, id)
    render conn, "show.json-api", data: content_type
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    content_type = Context.get!(ContentType, id)

    with {:ok, %ContentType{} = content_type} <- Context.update(content_type, attrs) do
      render conn, "show.json-api", data: content_type
    end
  end

  def delete(conn, %{"id" => id}) do
    content_type = Context.get!(ContentType, id)
    with {:ok, %ContentType{}} <- Context.delete(content_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
