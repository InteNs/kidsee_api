defmodule KidseeApi.Repo.Migrations.AddPostTable do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :content, :string
      add :title, :string
      add :content_type_id, references("content_type")
      add :user_id, references("user")
      add :status_id, references("post_status")
      add :location, :string
      timestamps()
    end
  end
end
