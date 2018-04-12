defmodule KidseeApi.Repo.Migrations.BirthdateToDatetime do
  use Ecto.Migration

  def change do
    alter table(:user) do
      modify :birthdate, :naive_datetime
    end
  end
end
