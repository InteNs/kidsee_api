defmodule KidseeApi.Repo.Migrations.AddPostTypeToPost do
  use Ecto.Migration

  def change do
    alter table("post") do
      add :post_type_id, references("post_type")
    end
  end
end
