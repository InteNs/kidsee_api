defmodule KidseeApi.Schemas.Rating do
  use KidseeApi.Schema
  alias KidseeApi.Repo
  alias KidseeApi.Schemas.{Rating, User}

  schema "rating" do
    field :object_type, :string
    field :object_id, :integer
    field :rating, :integer
    field :description, :string
    belongs_to :user, User

    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [
        :user
      ]
  end
  @doc false
  def changeset(%Rating{} = post, attrs) do
    post
    |> cast(attrs, [:object_type, :object_id, :rating, :description, :user_id])
    |> unique_constraint(:object_id, name: :index_on_uniqe_rating)
    |> validate_required([:object_type, :object_id, :rating, :user_id])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      Rating: JsonApi.resource do
        description "A Rating"
        attributes do
          object_type :string, "the rating object_type", required: true
          object_id :integer, "the rating object id", required: true
          rating :string, "the rating number", required: true
          description :string, "the rating description", required: false
          user_id :string, "the user_id of whom is giving the rating", required: true
        end
      end
    }
  end
end
