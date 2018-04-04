defmodule KidseeApi.Timeline.ContentType do
  use Ecto.Schema
  import Ecto.Changeset
  alias KidseeApi.Timeline.ContentType


  schema "content_type" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%ContentType{} = content_type, attrs) do
    content_type
    |> cast(attrs, [:name, :desciption])
    |> validate_required([:name, :desciption])
  end
end
