defmodule KidseeApiWeb.ThemeView do
  use KidseeApiWeb, :view

  has_many :locations, links: [ related: "/themes/:id/locations" ]

  attributes [
    :name,
    :icon
    ]

  def icon(theme, _) do
    KidseeApiWeb.Avatar.url({theme.icon, theme})
  end
end
