defmodule KidseeApiWeb.AnswerView do
  use KidseeApiWeb, :view

  has_one :assignment, serializer: KidseeApiWeb.AssignmentView

  attributes [
    :answer,
    :correct_answer
  ]
end
