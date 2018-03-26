defmodule KidseeApi.Timeline.Post.Post do
  use KidseeApi.Schema
  alias KidseeApi.Accounts.User
  alias KidseeApi.Timeline.Post.Post
  alias KidseeApi.Timeline.Post.PostStatus
  alias KidseeApi.Timeline.Post.ContentType
  alias KidseeApi.Timeline.Post.Comment

  schema "post" do
    field :content, :string
    field :post_location, :string, source: :location
    field :title, :string

    belongs_to :status, PostStatus
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
end
