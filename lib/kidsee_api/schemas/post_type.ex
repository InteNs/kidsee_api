defmodule KidseeApi.Schemas.PostType do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.PostType

  schema "post_type" do
    field :name, :string

    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%PostType{} = post_type, attrs) do
    post_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      post_type: JsonApi.resource do
        description "A post type"
        attributes do
          name :string, "the post type name", required: true
        end
      end
    }
  end
end
