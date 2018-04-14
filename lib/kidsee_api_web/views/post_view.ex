defmodule KidseeApiWeb.PostView do
  use KidseeApiWeb, :view

  has_one :user, serializer: KidseeApiWeb.UserView
  has_one :content_type, serializer: KidseeApiWeb.ContentTypeView
  has_one :status, serializer: KidseeApiWeb.StatusView
  has_many :comments, serializer: KidseeApiWeb.CommentView, include: true

  # location attribute is a reserved keyword in ja_serializer,
  # this is a workaround
  def attributes(post, _), do: Map.take(post, [:title, :location, :content])
end
