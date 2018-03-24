defmodule KidseeApi.Timeline.Post.ContentType do
  use Ecto.Schema
  import Ecto.Changeset
  alias KidseeApi.Timeline.Post.Post

  schema "content_type" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
