defmodule KidseeApi.PostFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Post
    alias KidseeApi.{StatusFactory, ContentTypeFactory, UserFactory}

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.PostView

    def post_factory do
      %Post{
        content:      "Example content",
        location:     "Example location",
        title:        "Example title",
        status:       StatusFactory.insert(:status),
        content_type: ContentTypeFactory.insert(:content_type),
        user:         UserFactory.insert(:user),
        comments:     []
      }
    end

    def invalid_post_factory do
      %Post{build(:post) |
        user: nil
      }
    end

    def jsonapi_post_factory do
      json_api_params_for(:post)
    end
  end
