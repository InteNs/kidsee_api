defmodule KidseeApi.Repo.Migrations.CreateDiscoveryAssignment do
  use Ecto.Migration

  def change do
    create table("discovery_assignment") do
      add :sort_order, :integer
      add :name, :string
      add :assignment_id, references("assignment")
      add :discovery_id, references("discovery")
      timestamps()
    end
  end
end
