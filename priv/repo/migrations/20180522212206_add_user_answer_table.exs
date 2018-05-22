defmodule KidseeApi.Repo.Migrations.AddUserAnswerTable do
  use Ecto.Migration

  def change do
    create table(:user_answer) do
      add :assignment_id, references("assignment")
      add :user_id, references("user")
      add :answer_id, references("answer")
      add :correct_answer, :boolean
      timestamps()
    end
  end
end
