defmodule KidseeApi.Repo.Migrations.AddAnswerType do
  use Ecto.Migration

  def change do
    create table(:answer_type) do
      add :name, :string
      timestamps()
    end
  end
end
