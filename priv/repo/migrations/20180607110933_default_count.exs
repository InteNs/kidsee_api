defmodule KidseeApi.Repo.Migrations.DefaultCount do
  use Ecto.Migration

  def change do
    alter table("location") do
      add :rating_count, :integer, default: 0
    end

    alter table("assignment") do
      add :rating_count, :integer, default: 0
    end

    alter table("post") do
      modify(:rating_count, :integer, default: 0)
    end
  end
end
