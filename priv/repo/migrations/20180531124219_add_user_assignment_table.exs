defmodule KidseeApi.Repo.Migrations.AddUserAssignmentTable do
  use Ecto.Migration

  def change do
    create table(:user_assignment) do
      add :assignment_id, references("assignment")
      add :user_id, references("user")
      timestamps()
    end
  end
end
