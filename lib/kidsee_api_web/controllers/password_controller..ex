defmodule KidseeApiWeb.PasswordController do
  use KidseeApiWeb, :controller

  alias KidseeApi.Context
  alias KidseeApi.Schemas.User
  alias KidseeApi.Repo
  alias KidseeApi.Email
  alias KidseeApi.Mailer

  action_fallback KidseeApiWeb.FallbackController
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")

  def update(conn, %{"id" => id, "data" => params}) do
    user = Context.get!(User, id)
    old_password = user.password
    new_password = get_in(params, ["attributes", "password"])
    if String.equivalent?(new_password, old_password) do
      conn = put_status(conn, :unprocessable_entity)
      text conn, "New password cannot be the same as the old password!"
    else
      user = Ecto.Changeset.change user, password: new_password
      case Repo.update user do
        {:ok, _}    -> conn |> send_succes("{\"message\":\Password has been updated!\"}")
        {:error, _} -> conn |> send_error("{\"message\":\Something went wrong!\"}")
        end
    end
  end

  def send_succes(conn, message) do
    send_resp(conn, 200, message)
  end

  def send_error(conn, message) do
    send_resp(conn, 422, message)
  end

  def reset(conn, %{"data" => params}) do
    email = get_in(params, ["attributes", "email"])
    user = Repo.get_by(User, email: email)
    plain_password = generate_password(10)
    password = Comeonin.Bcrypt.hashpwsalt(plain_password)
    user = Ecto.Changeset.change user, password: password
    case Repo.update user do
      {:ok, _}    -> Email.reset_password(email, plain_password) |> Mailer.deliver_now
                     conn |> send_succes("{\"message\":\"Password has been reset and email has been send!\"}")
      {:error, _} -> conn |> send_error("{\"message\"Something went wrong!\"}")
      end
  end

  def generate_password(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("")
  end
end
