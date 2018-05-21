defmodule KidseeApi.Schemas.AssignmentType do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.AssignmentType

  schema "assignment_type" do
    field :name, :string
    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%AssignmentType{} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      assignment_type: JsonApi.resource do
        description "A asignment type"
        attributes do
          name :string, "the assignment type name", required: true
        end
      end
    }
  end
end
