defmodule KidseeApi.ThemeLocationFactory do
  use ExMachina.Ecto, repo: KidseeApi.Repo

  alias KidseeApi.Schemas.ThemeLocation

  use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.ThemeLocationView

  def theme_location_factory do
    %ThemeLocation{
      theme: KidseeApi.ThemeFactory.insert(:theme),
      location: KidseeApi.LocationFactory.insert(:location)
    }
  end

  def invalid_theme_location_factory do
    %ThemeLocation{build(:theme_location) |
      theme: nil
    }
  end

  def jsonapi_theme_location_factory do
    json_api_params_for(:theme_location)
  end
end
