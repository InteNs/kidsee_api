defmodule KidseeApiWeb.ThemeView do
  use KidseeApiWeb, :view

  has_many :locations, serializer: KidseeApiWeb.LocationView
  attributes [
    :name
    ]

end
