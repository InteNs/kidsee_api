defmodule KidseeApiWeb.AnswerTypeController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.AnswerType
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    answer_types = AnswerType
                    |> build_query(conn, params)
                    |> Repo.all
    render(conn, "index.json-api", data: answer_types)
  end

  def create(conn, %{"data" => data}) do
    attrs = Params.to_attributes(data)
    with {:ok, %AnswerType{} = answer_type} <- Context.create(AnswerType, attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", answer_type_path(conn, :show, answer_type))
      |> render("show.json-api", data: answer_type)
    end
  end

  def show(conn, %{"id" => id}) do
    answer_type = Context.get!(AnswerType, id)
    render conn, "show.json-api", data: answer_type
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = Params.to_attributes(data)
    answer_type = Context.get!(AnswerType, id)

    with {:ok, %AnswerType{} = answer_type} <- Context.update(answer_type, attrs) do
      render conn, "show.json-api", data: answer_type
    end
  end

  def delete(conn, %{"id" => id}) do
    answer_type = Context.get!(AnswerType, id)
    with {:ok, %AnswerType{}} <- Context.delete(answer_type) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    Map.merge(AnswerType.swagger_definitions, SwaggerCommon.definitions)
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:answer_type)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:answer_type)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:answer_type)

    response 201, "created", JsonApi.single(:answer_type)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:answer_type)

    response 200, "OK", JsonApi.single(:answer_type)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
