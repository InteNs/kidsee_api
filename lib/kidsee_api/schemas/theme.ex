defmodule KidseeApi.Schemas.Theme do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{Theme, Location, ThemeLocation}

  schema "theme" do
    field :name, :string
    many_to_many :locations, Location, join_through: ThemeLocation
    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [
        locations: ^Repo.preload_schema(Location)
      ]
  end

  def preload(query, :nested) do
    from q in query
  end

  @doc false
  def changeset(%Theme{} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> put_assoc(:locations, load_themes(attrs))
    |> validate_required([:name])
  end

  def load_themes(attrs) do
    case attrs["locations_ids"] || [] do
      [] -> []
      ids -> Repo.all from r in Location, where: r.id in ^ids
    end
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      theme: JsonApi.resource do
        description "A theme"
        attributes do
          name :string, "the theme name", required: true
        end
        relationship :locations
      end
    }
  end
end
