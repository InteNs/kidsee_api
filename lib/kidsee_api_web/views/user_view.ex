defmodule KidseeApiWeb.UserView do
  use KidseeApiWeb, :view

  attributes [
    :username,
    :email,
    :birthdate,
    :school,
    :city,
    :avatar
  ]
end
