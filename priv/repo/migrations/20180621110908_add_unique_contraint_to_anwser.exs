defmodule KidseeApi.Repo.Migrations.AddUniqueContraintToAnwser do
  use Ecto.Migration

  def change do
    create unique_index(:answer, [:id])
  end
end
