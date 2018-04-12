defmodule KidseeApi.Context do
  alias KidseeApi.Repo

  def create(schema, attributes) do
    schema
    |> apply(:changeset, [struct(schema), attributes])
    |> Repo.insert()
  end

  def update(individual, attributes) do
    individual
    |> Map.fetch!(:__struct__)
    |> apply(:changeset, [individual, attributes])
    |> Repo.update()
  end

  def get!(schema, id) do
    Repo.get!(schema, id)
  end

  def delete(%{} = individual) do
    Repo.delete(individual)
  end
end
