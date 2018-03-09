defmodule KidseeApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :email, :string
      add :birthdate, :date
      add :school, :string
      add :city, :string
      add :avatar, :string

      timestamps()
    end

  end
end
