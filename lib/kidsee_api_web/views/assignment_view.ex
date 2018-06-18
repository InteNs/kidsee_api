defmodule KidseeApiWeb.AssignmentView do
  use KidseeApiWeb, :view

  has_one :location, serializer: KidseeApiWeb.LocationView
  has_one :answer_type, serializer: KidseeApiWeb.AnswerTypeView
  has_one :assignment_type, serializer: KidseeApiWeb.AssignmentTypeView

  attributes [
    :name,
    :content,
    :description,
    :rating,
    :completed
  ]
end
