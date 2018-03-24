defmodule KidseeApi.Timeline.Post.PostStatus do
  use Ecto.Schema
  import Ecto.Changeset
  alias KidseeApi.Timeline.Post.Post

  @derive {Poison.Encoder, only: [:name]}
  schema "post_status" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
