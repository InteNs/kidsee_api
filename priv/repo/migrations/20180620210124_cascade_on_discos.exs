defmodule KidseeApi.Repo.Migrations.CascadeOnDiscos do
  use Ecto.Migration

  def change do
    drop constraint("discovery_assignment", "discovery_assignment_discovery_id_fkey")
    drop constraint("discovery_assignment", "discovery_assignment_assignment_id_fkey")
    alter table("discovery_assignment") do
      modify(:discovery_id, references(:discovery, on_delete: :delete_all))
      modify(:assignment_id, references(:assignment, on_delete: :delete_all))
    end
  end
end
