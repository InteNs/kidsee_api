defmodule KidseeApi.Repo.Migrations.AddLocationAsRelation do
  use Ecto.Migration

  def change do
    alter table("post") do
      remove :location
      add :location_id, references("location")
    end
  end
end
