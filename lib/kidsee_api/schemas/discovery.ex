defmodule KidseeApi.Schemas.Discovery do
  use KidseeApi.Schema

  alias KidseeApi.Schemas.Discovery

  schema "discovery" do
    field :name, :string

    timestamps()
  end

  def preload(query), do: query

  def changeset(%Discovery{} = discovery, attrs) do
    discovery
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def swagger_definitions do
    %{}
    # use PhoenixSwagger
    # %{
    #   discovery: JsonApi.resource do
    #     name "the name of the discovery"
    #   end
    # }
  end
end
