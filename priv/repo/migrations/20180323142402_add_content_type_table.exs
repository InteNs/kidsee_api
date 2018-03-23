defmodule KidseeApi.Repo.Migrations.AddContentTypeTable do
  use Ecto.Migration

  def change do
    create table(:content_type) do
      add :name, :string
      add :description, :string
      timestamps()
    end
  end
end
