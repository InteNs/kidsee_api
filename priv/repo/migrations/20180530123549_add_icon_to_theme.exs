defmodule KidseeApi.Repo.Migrations.AddIconToTheme do
  use Ecto.Migration

  def change do
    alter table("theme") do
      add :icon, :string
    end
  end
end
