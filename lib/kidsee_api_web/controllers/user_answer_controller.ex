defmodule KidseeApiWeb.UserAnswerController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.UserAnswer
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  @whitelist ~w(name answer_id correct_answer)
  def build_filter_query(query, attr, value, _conn) when attr in @whitelist, do: filter(query, attr, value)

  def index(conn, params) do
    answers = UserAnswer
                |> Repo.preload_schema
                |> build_query(conn, params)
                |> Repo.paginate(params)
    render(conn, "index.json-api", data: answers.entries, opts: [include: answer_includes()])
  end

  def create(conn, %{"data" => answer_params}) do
    answer_params = Params.to_attributes(answer_params)
    with {:ok, %UserAnswer{id: id}} <- Context.create(UserAnswer, answer_params) do
      user_answer = UserAnswer
             |> Repo.preload_schema
             |> Repo.get!(id)
      conn
      |> put_status(:created)
      |> put_resp_header("user_answer", answer_path(conn, :show, user_answer))
      |> render("show.json-api", data: user_answer, opts: [include: answer_includes()])
    end
  end

  def show(conn, %{"id" => id}) do
    user_answer = UserAnswer
           |> Repo.preload_schema
           |> Repo.get!(id)
    render(conn, "show.json-api", data: user_answer, opts: [include: answer_includes()])
  end

  def update(conn, %{"id" => id, "data" => answer_params}) do
    answer_params = Params.to_attributes(answer_params)
    user_answer = UserAnswer
           |> Repo.preload_schema
           |> Repo.get!(id)

    with {:ok, %UserAnswer{} = user_answer} <- Context.update(user_answer, answer_params) do
      render(conn, "show.json-api", data: user_answer)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_answer = UserAnswer
           |> Repo.get!(id)
    with {:ok, %UserAnswer{}} <- Context.delete(user_answer) do
      send_resp(conn, :no_content, "")
    end
  end

  def answer_includes, do: "user,assignment,answer"

  def swagger_definitions do
    Map.merge(
      UserAnswer.swagger_definitions,
      SwaggerCommon.definitions
    )
  end

  swagger_path :index do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    paging
    response 200, "OK", JsonApi.page(:user_answer)
    response 404, "not_found"
  end

  swagger_path :show do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    response 200, "OK", JsonApi.single(:user_answer)
    response 404, "not found"
  end

  swagger_path :create do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:user_answer)

    response 201, "created", JsonApi.single(:user_answer)
  end

  swagger_path :update do
    SwaggerCommon.content_type
    SwaggerCommon.auth
    SwaggerCommon.validation
    SwaggerCommon.body(:user_answer)

    response 200, "OK", JsonApi.single(:user_answer)
  end

  swagger_path :delete do
    SwaggerCommon.auth
    response 204, "no content"
    response 404, "not found"
  end
end
