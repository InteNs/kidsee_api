defmodule KidseeApi.Repo.Migrations.AddPostType do
  use Ecto.Migration

  def change do
    create table(:post_type) do
      add :name, :string
      timestamps()
    end
  end
end
