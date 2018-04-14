defmodule KidseeApiWeb.LocationController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Location
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    locations = Location
               |> Repo.all
    render(conn, "index.json-api", data: locations)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %Location{} = location} <- Context.create(Location, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", location_path(conn, :show, location))
      |> render("show.json-api", data: location)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Context.get!(Location, id)
    render(conn, "index.json-api", data: location)
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    location = Context.get!(Location, id)

    with {:ok, %Location{} = location} <- Context.update(location, attrs) do
      render conn, "show.json-api", data: location
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Context.get!(Location, id)
    with {:ok, %location{}} <- Context.delete(location) do
      send_resp(conn, :no_content, "")
    end
  end
end
