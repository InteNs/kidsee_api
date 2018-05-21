defmodule KidseeApi.Repo.Migrations.AddAssignmentTable do
  use Ecto.Migration

  def change do
    create table(:assignment) do
      add :name, :string
      add :description, :string
      add :location_id, references("location")
      add :assignment_type_id, references("assignment_type")
      add :rating, :float, default: 0
      timestamps()
    end
  end
end
