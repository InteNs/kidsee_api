defmodule KidseeApi.Repo.Migrations.AddUserToRating do
  use Ecto.Migration

  def change do
    alter table("rating") do
      add :user_id, references("user")
    end
  end
end
