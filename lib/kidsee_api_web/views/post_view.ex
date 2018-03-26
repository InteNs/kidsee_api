defmodule KidseeApiWeb.PostView do
  use KidseeApiWeb, :view

  has_one :user, serializer: KidseeApiWeb.UserView
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView
  has_one :status, serializer: KidseeApiWeb.PostStatusView
  has_many :comments, serializer: KidseeApiWeb.CommentView

  attributes [
    :content,
    :post_location,
    :title
  ]
end
