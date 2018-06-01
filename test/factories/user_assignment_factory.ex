defmodule KidseeApi.UserAssignmentFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.{User, Assignment, UserAssignment}
    alias KidseeApi.{UserFactory, AssignmentFactory}

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AnswerView

    def user_assignment_factory do
      %UserAssignment{
        user:           UserFactory.insert(:user),
        assignment:     AssignmentFactory.insert(:assignment),
      }

    end

    def invalid_user_assignment_factory do
      %UserAssignment{build(:user_assignment) |
        user: nil
    }
    end

    def jsonapi_user_assignment_factory do
      json_api_params_for(:user_assignment)
    end
  end