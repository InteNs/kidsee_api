defmodule KidseeApi.Schemas.Theme do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{Theme, Location, ThemeLocation}

  schema "theme" do
    field :name, :string
    many_to_many :locations, Location, join_through: ThemeLocation
    timestamps()
  end

  def preload(query) do
    from q in query
  end

  def preload(query, :nested) do
    from q in query
  end

  @doc false
  def changeset(%Theme{} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> load_locations(Map.get(attrs, "location_ids"))
    |> validate_required([:name])
  end

  def load_locations(changeset, nil), do: changeset
  def load_locations(changeset, ids) do
    put_assoc(changeset, :locations, Repo.all(from r in Location, where: r.id in ^ids))
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
