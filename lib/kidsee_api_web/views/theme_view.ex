defmodule KidseeApiWeb.ThemeView do
  use KidseeApiWeb, :view

  has_many :locations, links: [ related: "/themes/:id/locations" ]

  attributes [
    :name
    ]

end
