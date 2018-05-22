defmodule KidseeApi.Schemas.AnswerType do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.AnswerType

  schema "answer_type" do
    field :name, :string
    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%AnswerType{} = answer_type, attrs) do
    answer_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      answer_type: JsonApi.resource do
        description "A answer type"
        attributes do
          name :string, "the answer type name", required: true
        end
      end
    }
  end
end
