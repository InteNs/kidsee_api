
defmodule KidseeApi.Schemas.Answer do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.{Answer, AnswerType, Assignment}

    schema "answer" do
      field :answer, :string
      field :correct_answer, :boolean

      belongs_to :assignment, Assignment
      timestamps()
    end

    def preload(query) do
      from q in query,
        preload: [
          assignment: ^Repo.preload_schema(Assignment),
        ]
    end

    @doc false
    def changeset(%Answer{} = answer, attrs) do
      answer
      |> cast(attrs, [:answer, :correct_answer, :assignment_id])
      |> validate_required([:answer, :correct_answer, :assignment_id])
    end

    def swagger_definitions do
      use PhoenixSwagger
      %{
        answer: JsonApi.resource do
          description "A answer"
          attributes do
            name :string, "the answer name", required: true
            correct_answer :string, "if the answer is correct", required: true
          end
          relationship :assignment
        end
      }
    end
  end
