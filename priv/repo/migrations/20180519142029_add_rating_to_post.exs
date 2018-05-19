defmodule KidseeApi.Repo.Migrations.AddRatingToPost do
  use Ecto.Migration

  def change do
    alter table("post") do
      add :rating, :float, default: 0
    end
  end
end
