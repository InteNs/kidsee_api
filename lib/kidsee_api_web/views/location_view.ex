defmodule KidseeApiWeb.LocationView do
  use KidseeApiWeb, :view

  has_one :location_type, serializer: KidseeApiWeb.LocationTypeView
  has_one :themes, serializer: KidseeApiWeb.ThemeView

  attributes [
    :name,
    :description,
    :address,
    :lon,
    :lat,
    :rating,
    :website_link
  ]
end
