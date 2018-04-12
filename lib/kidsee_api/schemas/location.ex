
defmodule KidseeApi.Schemas.Location do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.Location
    schema "location" do
      field :name, :string
      field :description, :string
      field :adress, :string
      field :lat, :float
      field :lon, :float
    end

    @doc false
    def changeset(%Location{} = post, attrs) do
      post
      |> cast(attrs, [:name, :description, :adress, :lat, :lon])
      |> validate_required([:name, :adress])
    end
  end
