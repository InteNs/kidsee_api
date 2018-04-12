defmodule KidseeApi.Schemas.ContentType do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.ContentType

  schema "content_type" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  def preload(query), do: query

  @doc false
  def changeset(%ContentType{} = post, attrs) do
    post
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
