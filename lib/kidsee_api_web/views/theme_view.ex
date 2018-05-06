defmodule KidseeApiWeb.ThemeView do
  use KidseeApiWeb, :view

  has_one :locations, serializer: KidseeApiWeb.LocationView
  attributes [
    :name
    ]

end
