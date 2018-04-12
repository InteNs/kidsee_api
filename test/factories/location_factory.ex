defmodule KidseeApi.LocationFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Location

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.LocationView

    def location_factory do
      %Location{
        name:         "Example name",
        description:  "Example desciption",
        adress:       "Example adress",
        lat:          12.121342,
        lon:          32.345434
      }
    end

    def invalid_location_factory do
      %Location{build(:location) |
        name: nil
      }
    end

    def jsonapi_location_factory do
      json_api_params_for(:location)
    end
  end