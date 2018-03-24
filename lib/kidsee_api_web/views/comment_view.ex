defmodule KidseeApiWeb.CommentView do
  use KidseeApiWeb, :view
  alias KidseeApiWeb.CommentView

  attributes [
    :user_id,
    :content_type_id,
    :content
  ]
end
