
defmodule KidseeApi.Schemas.Location do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.{Location, LocationType, Theme, ThemeLocation}

    schema "location" do
      field :name, :string
      field :description, :string
      field :address, :string
      field :lat, :float
      field :lon, :float
      field :rating, :float
      belongs_to :location_type, LocationType
      many_to_many :themes, Theme, join_through: ThemeLocation
    end

    def preload(query) do
      from q in query,
        preload: [
          :location_type,
          themes: ^Repo.preload_schema(Theme)
        ]
    end

    @doc false
    def changeset(%Location{} = post, attrs) do
      post
      |> cast(attrs, [:rating, :name, :description, :address, :lat, :lon, :location_type_id])
      |> cast_assoc(:themes, load_themes(attrs))
      |> validate_required([:name, :address, :location_type_id])
      |> unique_constraint(:name)
    end

    def load_themes(attrs) do
      case attrs["themes_ids"] || [] do
        [] -> []
        ids -> Repo.all from r in Theme, where: r.id in ^ids
      end
    end

    def for_theme(query, nil), do: query
    def for_theme(query \\ Location, theme_id) do
      from l in query,
        join: tl in ThemeLocation,
        on: tl.location_id == l.id,
        where: tl.theme_id == ^theme_id
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
          relationship :location_type
          relationship :themes
        end
      }
    end
  end
