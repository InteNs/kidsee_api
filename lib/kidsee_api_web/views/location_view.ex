defmodule KidseeApiWeb.LocationView do
  use KidseeApiWeb, :view

  has_one :location_type, serializer: KidseeApiWeb.LocationTypeView
  has_many :themes, serializer: KidseeApiWeb.ThemeView

  attributes [
    :name,
    :description,
    :address,
    :lon,
    :lat,
    :rating
  ]
end
