defmodule KidseeApi.Repo.Migrations.AddLocationType do
  use Ecto.Migration

  def change do
    create table(:location_type) do
      add :name, :string
      add :description, :string
      timestamps()
    end
    alter table("location") do
      add :location_type_id, references("location_type")
    end
  end
end
