defmodule KidseeApi.Repo.Migrations.AddThemesLocationTable do
  use Ecto.Migration

  def change do
    create table("theme_location") do
      add :theme_id, references("theme", on_delete: :nilify_all)
      add :location_id, references("location", on_delete: :nilify_all)
      timestamps()
    end
  end
end
