defmodule KidseeApiWeb.RatingView do
  use KidseeApiWeb, :view

  attributes [
    :object_type,
    :object_id,
    :rating,
    :description
  ]

end
