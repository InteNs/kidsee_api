defmodule KidseeApi.Repo.Migrations.AddUniqueConstraintToAssignmentName do
  use Ecto.Migration

  def change do
    create unique_index(:assignment, [:name])
  end
end
