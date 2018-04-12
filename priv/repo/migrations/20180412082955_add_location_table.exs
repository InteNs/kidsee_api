defmodule KidseeApi.Repo.Migrations.AddLocationTable do
  use Ecto.Migration

  def change do
    create table(:location) do
      add :name, :string
      add :description, :string
      add :adress, :string
      add :lat, :float
      add :lon, :float
    end
  end
end
