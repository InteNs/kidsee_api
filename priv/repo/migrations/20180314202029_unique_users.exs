defmodule KidseeApi.Repo.Migrations.UniqueUsers do
  use Ecto.Migration

  def change do
    create unique_index(:user, [:email])
    create unique_index(:user, [:username])
  end
end
