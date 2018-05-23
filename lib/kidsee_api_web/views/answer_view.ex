defmodule KidseeApiWeb.AnswerView do
  use KidseeApiWeb, :view

  has_one :assignment, serializer: KidseeApiWeb.AssignmentView, include: true

  attributes [
    :answer,
    :correct_answer
  ]
end
