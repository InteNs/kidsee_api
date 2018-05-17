defmodule KidseeApiWeb.PasswordController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.User
  alias JaSerializer.Params
  alias KidseeApi.Repo

  action_fallback KidseeApiWeb.FallbackController

  def update(conn, %{"id" => id, "data" => params}) do
    user = Context.get!(User, id)
    old_password = user.password
    new_password = get_in(params, ["attributes", "password"])
    if String.equivalent?(new_password, old_password) do
      conn = put_status(conn, :unprocessable_entity)
      text conn, "New password cannot be the same as the new password!"
    else
      user = Ecto.Changeset.change user, password: new_password
      case Repo.update user do
        {:ok, struct}       -> conn |> send_succes
        {:error, changeset} -> conn |> send_error
        end
    end
  end

  def send_succes(conn) do
    conn = put_status(conn, :ok)
    text conn, "Password has been updated!"
  end

  def send_error(conn) do
    conn = put_status(conn, :unprocessable_entity)
    text conn, "Something went wrong!"
  end
end
