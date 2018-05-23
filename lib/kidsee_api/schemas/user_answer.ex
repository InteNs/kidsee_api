defmodule KidseeApi.Schemas.UserAnswer do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.{UserAnswer, User,  Answer, Assignment}

    schema "user_answer" do
      field :correct_answer, :boolean

      belongs_to :assignment, Assignment
      belongs_to :user, User
      belongs_to :answer, Answer

      timestamps()
    end

    def preload(query) do
      from q in query,
        preload: [
          :user, :answer,
          assignment: ^Repo.preload_schema(Assignment),
        ]
    end

    @doc false
    def changeset(%UserAnswer{} = user_answer, attrs) do
      user_answer
      |> cast(attrs, [:correct_answer, :assignment_id, :user_id, :answer_id])
      |> validate_required([:correct_answer, :assignment_id, :user_id, :answer_id])
    end

    def swagger_definitions do
      use PhoenixSwagger
      %{
        user_answer: JsonApi.resource do
          description "A user answer"
          attributes do
            correct_answer :string, "if the user answer is correct", required: true
          end
          relationship :assignment
          relationship :answer
          relationship :user
        end
      }
    end
  end
