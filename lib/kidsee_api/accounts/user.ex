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
    |> cast(attrs, [:username, :password, :email, :birthdate, :school, :city, :avatar])
    |> validate_required([:username, :password, :email, :birthdate])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
