
defmodule KidseeApi.Schemas.Assignment do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.{Assignment, AssignmentType, Location}

    schema "assignment" do
      field :name, :string
      field :description, :string
      field :rating, :float

      belongs_to :location, Location
      belongs_to :assignment_type, AssignmentType
      timestamps()
    end

    def preload(query) do
      from q in query,
        preload: [
          :assignment_type,
          location: ^Repo.preload_schema(Location)
        ]
    end

    @doc false
    def changeset(%Assignment{} = post, attrs) do
      post
      |> cast(attrs, [:name, :location_id, :assignment_type_id])
      |> validate_required([:name, :location_id , :assignment_type_id])
      |> unique_constraint(:name)
    end

    def swagger_definitions do
      use PhoenixSwagger
      %{
        assignment: JsonApi.resource do
          description "A assignment"
          attributes do
            name :string, "the assignment name", required: true
            description :string, "the assignment description", required: true
          end
          relationship :location
          relationship :assignment_type
        end
      }
    end
  end
