defmodule KidseeApi.Timeline.Post.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias KidseeApi.Accounts.User
  alias KidseeApi.Timeline.Post.Post
  alias KidseeApi.Timeline.Post.PostStatus
  alias KidseeApi.Timeline.Post.ContentType
  alias KidseeApi.Timeline.Post.Comment

  schema "post" do
    field :content, :string
    belongs_to :content_type, ContentType
    field :location, :string
    belongs_to :status, PostStatus
    field :title, :string
    belongs_to :user, User
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:content, :title, :content_type_id, :user_id, :status_id, :location])
    |> validate_required([:content, :title, :content_type_id, :user_id, :status_id, :location])
  end
end
