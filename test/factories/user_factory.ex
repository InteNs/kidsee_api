defmodule KidseeApi.UserFactory do
  defmacro __using__(_) do
    quote do
      alias KidseeApi.Accounts.User

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
    end
  end
end
