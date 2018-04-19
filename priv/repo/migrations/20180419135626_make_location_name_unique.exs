defmodule KidseeApi.Repo.Migrations.MakeLocationNameUnique do
  use Ecto.Migration

  def change do
    create unique_index(:location, [:name])
  end
end
