defmodule KidseeApi.Schemas.Comment do
  use KidseeApi.Schema
  alias KidseeApi.Schemas.{Comment, Post, ContentType, User}

  schema "comment" do
    field :content, :string
    belongs_to :post, Post
    belongs_to :user, User
    belongs_to :content_type, ContentType
    timestamps()
  end

  def preload(query) do
    from q in query,
      preload: [
        :content_type,
        user: ^Repo.preload_schema(User),
        post: ^Repo.preload_schema(Post),
      ]
  end

  def preload(query, :nested) do
    from q in query,
      preload: [:user, :content_type, :post]
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id, :user_id, :content_type_id])
    |> validate_required([:content, :post_id, :user_id, :content_type_id])
  end

  def swagger_definitions do
    use PhoenixSwagger
    %{
      comment: JsonApi.resource do
        description "A comment"
        attributes do
          content :string, "the content of the comment", required: true
        end
        relationship :post
        relationship :user
        relationship :content_type
      end
    }
  end
end
