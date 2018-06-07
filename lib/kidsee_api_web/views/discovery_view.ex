defmodule KidseeApiWeb.DiscoveryView do
  use KidseeApiWeb, :view

  has_one :assignments, serializer: KidseeApiWeb.AssignmentView

  attributes [:name]
end
