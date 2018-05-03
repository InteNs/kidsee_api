defmodule KidseeApi.Repo.Migrations.AddUniqeConstraintsToRating do
  use Ecto.Migration

  def up do
    create unique_index(:rating, [:object_type, :object_id, :user_id], name: :index_on_uniqe_rating)
  end

  def down do
    drop index(:rating, [:object_type, :object_id, :user_id], name: :index_on_uniqe_rating)
  end

end
