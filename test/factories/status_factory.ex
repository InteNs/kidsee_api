defmodule KidseeApi.StatusFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.Status

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.StatusView

    def status_factory do
      %Status{
        name:  "Example name"
      }
    end

    def invalid_status_factory do
      %Status{build(:status) |
        name: nil
      }
    end

    def jsonapi_status_factory do
      json_api_params_for(:status)
    end
  end