defmodule KidseeApi.Schemas.Post do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{Comment, Post, Status, ContentType, User}

  schema "post" do
    field :content, :string
    field :location, :string
    field :title, :string

    belongs_to :status, Status
    belongs_to :content_type, ContentType
    belongs_to :user, User

    has_many :comments, Comment
    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [
        :status, :content_type, :user,
        comments: ^Repo.preload_schema(Comment, :nested)
      ]
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:content, :title, :content_type_id, :user_id, :status_id, :location])
    |> validate_required([:content, :title, :content_type_id, :user_id, :status_id, :location])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      post: JsonApi.resource do
        description "A post"
        attributes do
          title :string, "Title of the post", required: true
          location :string, "location the post was made at", required: true
          content :string, "the content of the post", required: true
        end
        relationship :user
        relationship :content_type
        relationship :status
        relationship :comments, type: :has_many
      end
    }
  end
end
