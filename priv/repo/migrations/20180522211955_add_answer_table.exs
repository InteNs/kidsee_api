defmodule KidseeApi.Repo.Migrations.AddAnswerTable do
  use Ecto.Migration

  def change do
    create table(:answer) do
      add :assignment_id, references("assignment")
      add :answer, :string
      add :correct_answer, :boolean
      timestamps()
    end
  end
end
