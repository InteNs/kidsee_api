defmodule KidseeApi.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :content, :string
      add :post_id, references("post")
      add :content_type_id, references("content_type")
      add :user_id, references("user")
      timestamps()
    end

  end
end
