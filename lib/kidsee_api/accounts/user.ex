defmodule KidseeApi.Accounts.User do
  use KidseeApi.Schema
  alias KidseeApi.Accounts.User

  schema "user" do
    field :avatar, :string
    field :birthdate, :naive_datetime
    field :postal_code, :string
    field :email, :string
    field :password, :string
    field :school, :string
    field :username, :string

    timestamps()
  end

  def preload(query) do
    query
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email, :birthdate, :school, :postal_code, :avatar])
    |> validate_required([:username, :password, :email, :birthdate])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
