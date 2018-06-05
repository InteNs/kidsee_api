defmodule KidseeApiWeb.AnswerController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.Answer
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name answer_id correct_answer assignment_id)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    answers = Answer
                |> Repo.preload_schema
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: answers.entries, opts: [include: answer_includes()])
  end

  def create(conn, %{"data" => answer_params}) do
    answer_params = Params.to_attributes(answer_params)
    with {:ok, %Answer{id: id}} <- Context.create(Answer, answer_params) do
      answer = Answer
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("answer", answer_path(conn, :show, answer))
      |> render("show.json-api", data: answer, opts: [include: answer_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Answer
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: answer, opts: [include: answer_includes()])
  end

  def update(conn, %{"id" => id, "data" => answer_params}) do
    answer_params = Params.to_attributes(answer_params)
    answer = Answer
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %Answer{} = answer} <- Context.update(answer, answer_params) do
      render(conn, "show.json-api", data: answer)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Answer
           |> Repo.get!(id)
    with {:ok, %Answer{}} <- Context.delete(answer) do
      send_resp(conn, :no_content, "")
    end
  end

  def answer_includes, do: "assignment"

  def swagger_definitions do
    Map.merge(
      Answer.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:answer)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:answer)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:answer)

    response 201, "created", JsonApi.single(:answer)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:answer)

    response 200, "OK", JsonApi.single(:answer)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
