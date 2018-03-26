defmodule KidseeApiWeb.PostsView do
  use KidseeApiWeb, :view

  has_one :user, serializer: KidseeApiWeb.UsersView, include: true
  has_one :content_type, serializer: KidseeApiWeb.ContentTypesView, include: true
  has_one :status, serializer: KidseeApiWeb.StatusTypesView, include: true
  has_many :comments, serializer: KidseeApiWeb.CommentsView, include: true

  attributes [
    :title,
    :content,
    :location
  ]
end
