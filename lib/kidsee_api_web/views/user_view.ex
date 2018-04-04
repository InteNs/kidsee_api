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
end
