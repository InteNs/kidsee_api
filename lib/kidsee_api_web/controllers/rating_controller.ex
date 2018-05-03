defmodule KidseeApiWeb.RatingController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Rating
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def index(conn, _params) do
    ratings = Rating
               |> Repo.preload_schema
               |> Repo.all
    render(conn, "index.json-api", data: ratings)
  end

  def create(conn, %{"data" => rating_params}) do
   rating_params = Params.to_attributes(rating_params)
    with {:ok, %Rating{id: id}} <- Context.create(Rating, rating_params) do
      rating = Rating
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", rating_path(conn, :show, rating))
      |> render("show.json-api", data: rating, opts: [include: rating_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    rating = Rating
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: rating, opts: [include: rating_includes()])
  end

  def update(conn, %{"id" => id, "data" => rating_params}) do
    rating_params = Params.to_attributes(rating_params)
    rating = Rating
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Rating{} = rating} <- Context.update(rating, rating_params) do
      render(conn, "show.json-api", data: rating)
    end
  end

  def delete(conn, %{"id" => id}) do
    rating = Context.get!(Rating, id)
    with {:ok, %Rating{}} <- Context.delete(rating) do
      send_resp(conn, :no_content, "")
    end
  end

  def rating_includes, do: "user"

  def swagger_definitions do
    Map.merge(
      Rating.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:rating)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:rating)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:rating)

    response 201, "created", JsonApi.single(:rating)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:rating)

    response 200, "OK", JsonApi.single(:rating)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
