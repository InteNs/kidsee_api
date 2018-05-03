defmodule KidseeApi.Repo.Migrations.AddRatingTable do
  use Ecto.Migration

  def change do
    create table(:rating) do
      add :object_type, :string
      add :object_id, :integer
      add :rating, :integer
      add :description, :string
      timestamps()
    end
  end
end
