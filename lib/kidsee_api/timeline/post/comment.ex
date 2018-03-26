defmodule KidseeApi.Timeline.Post.Comment do
  use KidseeApi.Schema
  alias KidseeApi.Timeline.Post.Comment
  alias KidseeApi.Timeline.Post.Post
  alias KidseeApi.Timeline.Post.ContentType
  alias KidseeApi.Accounts.User

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
        :user, :content_type,
        post: ^Repo.preload_schema(Post),
      ]
  end

  def preload(query, :nested) do
    from q in query,
      preload: [:user, :content_type]
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id, :user_id, :content_type_id])
    |> validate_required([:content, :post_id, :user_id, :content_type_id])
  end
end
