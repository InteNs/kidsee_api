defmodule KidseeApiWeb.PostView do
  use KidseeApiWeb, :view

  has_one :user, serializer: KidseeApiWeb.UserView, include: true
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView, include: true
  has_one :status, serializer: KidseeApiWeb.StatusTypeView, include: true
  has_many :comments, serializer: KidseeApiWeb.CommentView, include: true

  attributes [
    :title,
    :content,
    :location
  ]
end
