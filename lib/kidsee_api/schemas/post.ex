defmodule KidseeApi.Schemas.Post do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{ThemeLocation, Comment, Post, Status, ContentType, User, Location}

  schema "post" do
    field :content, :string
    field :title, :string
    field :rating, :float

    belongs_to :status, Status
    belongs_to :content_type, ContentType
    belongs_to :user, User
    belongs_to :location, Location

    has_many :comments, Comment
    timestamps()
  end

  def for_theme(query, nil), do: query
  def for_theme(query \\ Post, theme_id) do
    from p in query,
      join: l in assoc(p, :location),
      join: tl in ThemeLocation, on: tl.location_id == l.id,
      where: tl.theme_id == ^theme_id
  end

  def preload(query) do
    from q in query,
      preload: [
        :status, :content_type, :user, :location,
        comments: ^Repo.preload_schema(Comment, :nested)
      ]
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:rating, :content, :title, :content_type_id, :user_id, :status_id, :location_id])
    |> validate_required([:content, :title, :content_type_id, :user_id, :status_id, :location_id])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      post: JsonApi.resource do
        description "A post"
        attributes do
          title :string, "Title of the post", required: true
          content :string, "the content of the post", required: true
        end
        relationship :user
        relationship :content_type
        relationship :location
        relationship :status
        relationship :comments, type: :has_many
      end
    }
  end
end
