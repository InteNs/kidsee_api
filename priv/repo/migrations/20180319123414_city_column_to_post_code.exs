defmodule KidseeApi.Repo.Migrations.CityColumnToPostCode do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :postal_code, :string
    end
  end
end
