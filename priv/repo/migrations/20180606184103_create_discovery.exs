defmodule KidseeApi.Repo.Migrations.CreateDiscovery do
  use Ecto.Migration

  def change do
    create table("discovery") do
      add :name, :string
      timestamps()
    end

    create unique_index(:discovery, [:name])
  end
end
