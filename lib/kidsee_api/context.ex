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

  def populate_rating_object(%KidseeApi.Schemas.Rating{} = rating) do
    import Ecto.Query
    schema = Module.concat(KidseeApi.Schemas, String.capitalize(rating.object_type))
    object = Repo.get!(schema, rating.object_id)

    ratings = KidseeApi.Repo.all(from q in KidseeApi.Schemas.Rating,
      where: q.object_type == ^rating.object_type,
      where: q.object_id == ^rating.object_id
    )
    KidseeApi.Context.update(object, %{rating: get_average(ratings)})
  end

  def get_average(ratings) do
    ratings
    |> Enum.map(&(&1.rating))
    |> Statistics.median
  end
end
