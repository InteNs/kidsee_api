defmodule KidseeApiWeb.CommentView do
  use KidseeApiWeb, :view
  alias KidseeApiWeb.CommentView

  has_one :user, serializer: KidseeApiWeb.UserView, include: true
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView, include: :true

  attributes [
    :content
  ]

end
