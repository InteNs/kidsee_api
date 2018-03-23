defmodule KidseeApi.Repo.Migrations.AddPostStatusTable do
  use Ecto.Migration

  def change do
    create table(:post_status) do
      add :name, :string
      timestamps()
    end
  end
end
