defmodule KidseeApi.ThemeFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Theme

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.ThemeView

    def theme_factory do
      %Theme{
        name:         "Example name",
        locations:    []
      }
    end

    def invalid_theme_factory do
      %Theme{build(:theme) |
        name: nil
    }
    end

    def jsonapi_theme_factory do
      json_api_params_for(:theme)
    end
  end
