defmodule KidseeApiWeb.LocationView do
  use KidseeApiWeb, :view

  attributes [
    :name,
    :description,
    :adress,
    :lon,
    :lat
  ]
end
