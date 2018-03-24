defmodule KidseeApiWeb.PostView do
  use KidseeApiWeb, :view
  alias KidseeApiWeb.PostView

  has_one :user, serializer: KidseeApiWeb.UserView, include: true
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView, include: true
  has_one :status, serializer: KidseeApiWeb.StatusTypeView, include: true

  attributes [
    :title,
    :content,
    :location
  ]
end
