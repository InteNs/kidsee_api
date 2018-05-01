defmodule KidseeApiWeb.LocationView do
  use KidseeApiWeb, :view

  has_one :location_type, serializer: KidseeApiWeb.LocationTypeView

  attributes [
    :name,
    :description,
    :address,
    :lon,
    :lat
  ]
end
