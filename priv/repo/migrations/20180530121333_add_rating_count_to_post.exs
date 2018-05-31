defmodule KidseeApi.Repo.Migrations.AddRatingCountToPost do
  use Ecto.Migration

  def change do
    alter table("post") do
      add :rating_count, :integer
    end
  end
end
