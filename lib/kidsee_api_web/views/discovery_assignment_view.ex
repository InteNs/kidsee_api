defmodule KidseeApiWeb.DiscoveryAssignmentView do
  use KidseeApiWeb, :view

  has_one :assignment, serializer: KidseeApiWeb.AssignmentView
  has_one :discovery, serializer: KidseeApiWeb.DiscoveryView

  attributes [:name, :sort_order]
end
