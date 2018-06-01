defmodule KidseeApi.Schemas.Role do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.Role

  schema "role" do
    field :name, :string

    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%Role{} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      role: JsonApi.resource do
        description "A role"
        attributes do
          name :string, "the role name", required: true
        end
      end
    }
  end
end
