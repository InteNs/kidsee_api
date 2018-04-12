defmodule KidseeApi.ContentTypeFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.ContentType

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.ContentTypeView

    def content_type_factory do
      %ContentType{
        name:         "Example name",
        description:  "Example description",
      }
    end

    def invalid_content_type_factory do
      %ContentType{build(:content_type) |
        name: nil
    }
    end

    def jsonapi_content_type_factory do
      json_api_params_for(:content_type)
    end
  end