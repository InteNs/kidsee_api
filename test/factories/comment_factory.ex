defmodule KidseeApi.CommentFactory do
  use ExMachina.Ecto, repo: KidseeApi.Repo

  alias KidseeApi.Schemas.Comment
  alias KidseeApi.{PostFactory, UserFactory, ContentTypeFactory}

  use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.CommentView

  def comment_factory do
    %Comment{
      content:      "Exmaple name",
      post:         PostFactory.insert(:post),
      user:         UserFactory.insert(:user),
      content_type: ContentTypeFactory.insert(:content_type)
    }
  end

  def invalid_comment_factory do
    %Comment{(build(:comment)) |
      content: nil
    }
  end

  def jsonapi_comment_factory do
    json_api_params_for(:comment)
  end
end
