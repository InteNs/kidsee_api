defmodule KidseeApi.RoleFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Role

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.RoleView

    def role_factory do
      %Role{
        name:  "Example name"
      }
    end

    def invalid_role_factory do
      %Role{build(:role) |
        name: nil
      }
    end

    def jsonapi_role_factory do
      json_api_params_for(:role)
    end
  end