defmodule KidseeApiWeb.CommentsView do
  use KidseeApiWeb, :view

  has_one :user, serializer: KidseeApiWeb.UsersView, include: true
  has_one :content_type, serializer: KidseeApiWeb.ContentTypesView, include: :true

  attributes [
    :content
  ]

end
