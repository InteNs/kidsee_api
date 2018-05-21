defmodule KidseeApi.AssignmentFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.{Assignment, AssignmentType}
    alias KidseeApi.{LocationFactory, AssignmentFactory, AssignmentTypeFactory}

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AssignmentView

    def assignment_factory do
      %Assignment{
        name:            "Example name",
        description:     "Example description",
        location:        LocationFactory.insert(:location),
        assignment_type: AssignmentTypeFactory.insert(:assignment_type)
      }
    end

    def invalid_assignment_factory do
      %Assignment{build(:assignment) |
        name: nil
    }
    end

    def jsonapi_assignment_factory do
      json_api_params_for(:assignment)
    end
  end