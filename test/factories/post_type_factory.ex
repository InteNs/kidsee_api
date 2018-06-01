defmodule KidseeApi.PostTypeFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.PostType

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.PostTypeView

    def post_type_factory do
      %PostType{
        name:  "Example name"
      }
    end

    def invalid_post_type_factory do
      %PostType{build(:post_type) |
        name: nil
      }
    end

    def jsonapi_post_type_factory do
      json_api_params_for(:post_type)
    end
  end