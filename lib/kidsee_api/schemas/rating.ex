defmodule KidseeApi.Schemas.Rating do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.Rating

  schema "rating" do
    field :object_type, :string
    field :object_id, :integer
    field :rating, :integer
    field :description, :string

    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%Rating{} = post, attrs) do
    post
    |> cast(attrs, [:object_type, :object_id, :rating, :description])
    |> validate_required([:object_type, :object_id, :rating])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      Rating: JsonApi.resource do
        description "A Rating"
        attributes do
          object_type :string, "the rating object_type", required: true
          object_id :integer, "the rating object id", required: true
          rating :string, "the rating number", required: true
          description :string, "the rating description", required: false
        end
      end
    }
  end
end
