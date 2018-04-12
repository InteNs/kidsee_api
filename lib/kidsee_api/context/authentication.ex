defmodule KidseeApi.Context.Authentication do
  @moduledoc """
    context with logic for authentication
  """

  import Ecto.Query, warn: false
  alias KidseeApi.Repo
  alias KidseeApi.Schemas.User

  @doc """
  checks if the given password matches the given user
  and returns the token if it matches.
  """
  def authenticate(%{user: user, password: password}) do
    # Does password match the one stored in the database?
    case Comeonin.Bcrypt.checkpw(password, user.password) do
      true ->
        # create and return the token
        KidseeApiWeb.Guardian.encode_and_sign(user)
      _ ->
        # return an error
        {:error, :unauthorized}
    end
  end

  @doc """
  gets a single user with email or username equal to `string`
  """

  def get_user_by_identification!(string) do
    Repo.one!(from u in User,
      where: u.email == ^string,
      or_where: u.username == ^string
    )
  end
end
