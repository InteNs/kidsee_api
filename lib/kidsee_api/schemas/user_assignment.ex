defmodule KidseeApi.Schemas.UserAssignment do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.{User, Assignment, UserAssignment}

    schema "user_assignment" do
      belongs_to :assignment, Assignment
      belongs_to :user, User

      timestamps()
    end

    def preload(query) do
      from q in query,
        preload: [
          user: ^Repo.preload_schema(User),
          assignment: ^Repo.preload_schema(Assignment),
        ]
    end

    @doc false
    def changeset(%UserAssignment{} = user_answer, attrs) do
      user_answer
      |> cast(attrs, [:assignment_id, :user_id])
      |> validate_required([:assignment_id, :user_id])
    end

    def swagger_definitions do
      use PhoenixSwagger
      %{
        user_answer: JsonApi.resource do
          description "A user assginemnt (user that has fulfilled a assignment"
          attributes do
          end
          relationship :assignment
          relationship :user
        end
      }
    end
  end
