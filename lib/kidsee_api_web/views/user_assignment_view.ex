defmodule KidseeApiWeb.UserAssignmentView do
  use KidseeApiWeb, :view

  has_one :assignment, serializer: KidseeApiWeb.AssignmentView
  has_one :user, serializer: KidseeApiWeb.UserView

  attributes [
  ]
end
