defmodule KidseeApi.Repo.Migrations.AddAssignmentTypeTable do
  use Ecto.Migration

  def change do
    create table(:assignment_type) do
      add :name, :string
      timestamps()
    end
  end
end
