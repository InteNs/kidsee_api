defmodule KidseeApiWeb.CommentView do
  use KidseeApiWeb, :view

  has_one :post, serializer: KidseeApiWeb.PostView
  has_one :user, serializer: KidseeApiWeb.UserView
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView

  attributes [
    :content
  ]

end
