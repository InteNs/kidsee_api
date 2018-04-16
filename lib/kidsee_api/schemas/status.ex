defmodule KidseeApi.Schemas.Status do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.Status

  schema "status" do
    field :name, :string

    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%Status{} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      status: JsonApi.resource do
        description "A status"
        attributes do
          name :string, "the status name", required: true
        end
      end
    }
  end
end
