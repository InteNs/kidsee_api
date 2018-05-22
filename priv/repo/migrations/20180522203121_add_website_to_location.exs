defmodule KidseeApi.Repo.Migrations.AddWebsiteToLocation do
  use Ecto.Migration

  def change do
    alter table("location") do
      add :website_link, :string
    end
  end
end
