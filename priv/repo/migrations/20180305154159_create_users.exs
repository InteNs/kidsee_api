defmodule KidseeApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :birthdate, :date
      add :city, :string
      add :avatar, :string
      add :school, :string

      timestamps()
    end

  end
end
