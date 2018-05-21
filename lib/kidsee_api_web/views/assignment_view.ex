defmodule KidseeApiWeb.AssignmentView do
  use KidseeApiWeb, :view

  has_one :location, serializer: KidseeApiWeb.LocationView, include: true
  has_one :assignment_type, serializer: KidseeApiWeb.AssignmentView, include: true

  attributes [
    :name,
    :content,
    :description,
    :rating
  ]
end
