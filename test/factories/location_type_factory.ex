defmodule KidseeApi.LocationTypeFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.LocationType

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.LocationTypeView

    def location_type_factory do
      %LocationType{
        name:         "Example name",
        description:  "Example description",
      }
    end

    def invalid_location_type_factory do
      %LocationType{build(:content_type) |
        name: nil
    }
    end

    def jsonapi_location_type_factory do
      json_api_params_for(:content_type)
    end
  end