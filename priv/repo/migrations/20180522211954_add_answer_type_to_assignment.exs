defmodule KidseeApi.Repo.Migrations.AddAnswerTypeToAssignment do
  use Ecto.Migration

  def change do
    alter table("assignment") do
      add :answer_type_id, references("answer_type")
    end
  end
end
