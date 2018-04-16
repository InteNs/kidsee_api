defmodule KidseeApiWeb.LocationView do
  use KidseeApiWeb, :view

  attributes [
    :name,
    :description,
    :address,
    :lon,
    :lat
  ]
end
