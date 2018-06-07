defmodule KidseeApi.Schemas.Theme do
  use KidseeApi.Schema
  use Arc.Ecto.Schema
  alias KidseeApi.Schemas.{Theme, Location, ThemeLocation}

  schema "theme" do
    field :name, :string
    field :icon, KidseeApiWeb.Avatar.Type 
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
  def changeset(%Theme{id: id} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> cast_icon(id, attrs)
    |> load_locations(Map.get(attrs, "location_ids"))
    |> validate_required([:name])
  end

  def cast_icon(changeset, theme_id, %{"icon" => icon} = attrs) do
    if Map.has_key?(attrs, "icon") do
      icon = %{file_name: "#{theme_id}_icon.png", binary: KidseeApiWeb.Avatar.decode!(icon)}
      if %{binary: nil} do
        changeset
      else
        cast_attachments(changeset, [icon], [icon])
      end
    end
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
          icon :string, "url to the theme icon"
        end
        relationship :locations
      end
    }
  end
end
