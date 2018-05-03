defmodule KidseeApi.RatingFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Rating

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.RatingView

    def rating_factory do
      %Rating{
        object_type: "Example object type",
        object_id:   1,
        rating:      5,
        description: "Example description"

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