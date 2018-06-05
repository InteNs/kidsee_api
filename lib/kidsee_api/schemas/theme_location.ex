defmodule KidseeApi.Schemas.ThemeLocation do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{Location, Theme, ThemeLocation}

  schema "theme_location" do
    belongs_to :theme, Theme
    belongs_to :location, Location
    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [:location, :theme]
  end

  def changeset(%ThemeLocation{} = theme_location, attrs) do
    theme_location
    |> cast(attrs, [:theme_id, :location_id])
    |> validate_required([:theme_id, :location_id])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      theme_location: JsonApi.resource do
        description "A theme_location"
        relationship :theme
        relationship :location
      end
    }
  end
end
