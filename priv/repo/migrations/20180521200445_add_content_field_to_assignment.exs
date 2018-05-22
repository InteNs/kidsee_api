defmodule KidseeApi.Repo.Migrations.AddContentFieldToAssignment do
  use Ecto.Migration

  def change do
    alter table("assignment") do
      add :content, :string
    end
  end
end
