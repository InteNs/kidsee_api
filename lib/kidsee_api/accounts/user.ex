defmodule KidseeApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias KidseeApi.Accounts.User


  schema "users" do
    field :avatar, :string
    field :birthdate, :date
    field :city, :string
    field :email, :string
    field :password, :string
    field :school, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :birthdate, :city, :avatar, :school])
    |> validate_required([:username, :email, :password, :birthdate, :city, :avatar, :school])
  end
end
