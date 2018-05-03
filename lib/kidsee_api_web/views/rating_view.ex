defmodule KidseeApiWeb.RatingView do
  use KidseeApiWeb, :view
  has_one :user, serializer: KidseeApiWeb.UserView

  attributes [
    :object_type,
    :object_id,
    :rating,
    :description
  ]

end
