defmodule KidseeApiWeb.UserView do
  use KidseeApiWeb, :view

  attributes [
    :username,
    :email,
    :birthdate,
    :school,
    :postal_code,
    :avatar
  ]

  def avatar(user, _conn) do
    KidseeApiWeb.Avatar.url({user.avatar, user})
  end
end
