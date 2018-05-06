defmodule KidseeApi.Repo.Migrations.AddThemesTable do
  use Ecto.Migration

  def change do
    create table("theme") do
      add :name, :string
      timestamps()
    end
  end
end
