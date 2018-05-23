defmodule KidseeApiWeb.UserAnswerView do
  use KidseeApiWeb, :view

  has_one :assignment, serializer: KidseeApiWeb.AssignmentView, include: true
  has_one :user, serializer: KidseeApiWeb.UserView, include: true
  has_one :answer, serializer: KidseeApiWeb.AssignmentView, include: true


  attributes [
    :correct_answer
  ]
end
