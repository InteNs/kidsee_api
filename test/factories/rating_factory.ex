defmodule KidseeApi.RatingFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Rating

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.RatingView
    alias KidseeApi.{UserFactory, LocationFactory}

    def rating_factory do
      location =  LocationFactory.insert(:location)
      %Rating{
        object_type: "location",
        object_id:   location.id,
        rating:      5,
        description: "Example description",
        user:        UserFactory.insert(:user)
      }
    end

    def invalid_rating_factory do
      %Rating{build(:rating) |
        object_type: nil
    }
    end

    def jsonapi_rating_factory do
      json_api_params_for(:rating)
    end
  end