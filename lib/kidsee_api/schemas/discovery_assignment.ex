defmodule KidseeApi.Schemas.DiscoveryAssignment do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{Discovery, Assignment, DiscoveryAssignment}

  schema "discovery_assignment" do
    field :name, :string
    field :sort_order, :integer

    belongs_to :discovery, Discovery
    belongs_to :assignment, Assignment

    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [
        :discovery,
        assignment: ^Repo.preload_schema(Assignment)
      ]
  end

  def changeset(%DiscoveryAssignment{} = discovery_assignment, attrs) do
    discovery_assignment
    |> cast(attrs, [:name, :sort_order, :assignment_id, :discovery_id])
    |> validate_required([:name, :sort_order, :assignment_id, :discovery_id])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      discovery_assignment: JsonApi.resource do
        attributes do
          name :string, "the name"
          sort_order :integer, "the order of the discovery assignment"
        end
        relationship :discovery
        relationship :assignment
      end
    }
  end
end
