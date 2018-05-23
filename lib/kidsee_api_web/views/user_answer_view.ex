defmodule KidseeApiWeb.UserAnswerView do
  use KidseeApiWeb, :view

  has_one :assignment, serializer: KidseeApiWeb.AssignmentView
  has_one :user, serializer: KidseeApiWeb.UserView
  has_one :answer, serializer: KidseeApiWeb.AssignmentView

  attributes [
    :correct_answer
  ]
end
