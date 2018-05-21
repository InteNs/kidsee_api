defmodule KidseeApi.AssignmentTypeFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.AssignmentType

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AssignmentTypeView

    def assignment_type_factory do
      %AssignmentType{
        name:         "Example name",
      }
    end

    def invalid_assignment_type_factory do
      %AssignmentType{build(:assignment_type) |
        name: nil
    }
    end

    def jsonapi_assignment_type_factory do
      json_api_params_for(:assignment_type)
    end
  end