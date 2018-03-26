defmodule KidseeApi.UserFactory do
  use ExMachina.Ecto, repo: KidseeApi.Repo

  alias KidseeApi.Accounts.User

  use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.UsersView

  def user_factory do
    %User{
      email:     sequence(:email, &"email-#{&1}@example.com"),
      username:  sequence(:username, &"test_user_#{&1}"),
      password:  Comeonin.Bcrypt.hashpwsalt("test123"),
      birthdate: Faker.Date.date_of_birth(),
      avatar:    "-",
      city:      Faker.Address.city(),
      school:    "Avans"
    }
  end

  def invalid_user_factory do
    %User{build(:user) |
      email: nil
    }
  end

  def jsonapi_user_factory do
    json_api_params_for(:user)
    |> put_in(["data", "attributes", "password"], Comeonin.Bcrypt.hashpwsalt("test123"))
  end
end
