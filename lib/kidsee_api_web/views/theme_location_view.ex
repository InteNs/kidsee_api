defmodule KidseeApiWeb.ThemeLocationView do
  use KidseeApiWeb, :view

  has_one :theme, serializer: KidseeApiWeb.ThemeView
  has_one :location, serializer: KidseeApiWeb.LocationView
end
