
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

    def swagger_definitions do
      use PhoenixSwagger
      %{
        location: JsonApi.resource do
          description "A location"
          attributes do
            name :string, "the location name", required: true
            description :string, "the location description", required: true
            adress :string, "the location address", required: true
            lat :float, "the lattitude of the location", required: true
            lon :float, "the longitude of the location", required: true
          end
        end
      }
    end
  end
