defmodule KidseeApi.Schemas.LocationType do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.LocationType

  schema "location_type" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%LocationType{} = post, attrs) do
    post
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      location_type: JsonApi.resource do
        description "A location type"
        attributes do
          name :string, "the location type name", required: true
          description :string, "the location type description", required: true
        end
      end
    }
  end
end
