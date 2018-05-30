defmodule KidseeApi.LocationFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Location

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.LocationView

    def location_factory do
      %Location{
        name:          Faker.Name.name(),
        description:   Faker.Name.name(),
        address:       Faker.Address.street_address(),
        lat:           Faker.Address.latitude(),
        lon:           Faker.Address.longitude(),
        website_link:  Faker.Internet.url(),
        themes:        []
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
