defmodule KidseeApi.Schemas.Discovery do
  use KidseeApi.Schema

  alias KidseeApi.Schemas.{Discovery, Assignment, DiscoveryAssignment}

  schema "discovery" do
    field :name, :string

    many_to_many :assignments, Assignment, join_through: DiscoveryAssignment, on_replace: :delete

    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [
        assignments: ^Repo.preload_schema(Assignment)
      ]
  end

  def changeset(%Discovery{} = discovery, attrs) do
    discovery
    |> cast(attrs, [:name])
    |> put_assoc(:assignments, load_assignments(attrs))
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def embed_assignments(changeset, nil), do: changeset
  def embed_assignments(changeset, assignments) do
    put_assoc(changeset, :assignments, assignments)
  end

  def load_assignments(attrs) do
    if Map.has_key?(attrs, "assignments_ids") do
      Repo.all from a in Assignment,
        where: a.id in ^Map.fetch!(attrs, "assignments_ids")
    else
      nil
    end
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      discovery: JsonApi.resource do
        description "a discovery"
        attributes do
          name :string, "the name of the discovery"
        end
      end
    }
  end
end
