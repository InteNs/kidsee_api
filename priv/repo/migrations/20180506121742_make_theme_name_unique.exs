defmodule KidseeApi.Repo.Migrations.MakeThemeNameUnique do
  use Ecto.Migration

  def change do
    create unique_index(:theme, [:name])
    end
end
