defmodule KidseeApiWeb.PostView do
  use KidseeApiWeb, :view

  has_one :user, serializer: KidseeApiWeb.UserView
  has_one :location, serializer: KidseeApiWeb.LocationView
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView
  has_one :post_type, serializer: KidseeApiWeb.PostTypeView
  has_one :status, serializer: KidseeApiWeb.StatusView
  has_many :comments, serializer: KidseeApiWeb.CommentView, include: true

  attributes [
    :title,
    :content,
    :rating,
    :rating_count
  ]
end
