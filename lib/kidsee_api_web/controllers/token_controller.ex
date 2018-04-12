defmodule KidseeApiWeb.TokenController do
  use KidseeApiWeb, :controller

  action_fallback KidseeApiWeb.FallbackController

  alias KidseeApi.Schemas.User
  alias KidseeApi.Context.Authentication
  alias Ecto.Changeset

  def create(conn, %{"identification" => identification, "password" => password}) do
    with %User{} = user <- Authentication.get_user_by_identification!(identification) do
      with {:ok, token, _claims} <- Authentication.authenticate(%{user: user, password: password}) do
        render conn, "token.json-api", token: token, user: user
      end
    end
  end

  def create(_conn, params) do
    fields = %{username: :string, email: :string, password: :string}
    changeset = {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required(Map.keys(fields))
    {:error, changeset}
  end
end
