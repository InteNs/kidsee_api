defmodule KidseeApi.Repo.Migrations.AddRatingToLocation do
  use Ecto.Migration

  def change do
    alter table("location") do
      add :rating, :float
    end
  end
end
