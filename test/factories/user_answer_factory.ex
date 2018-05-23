defmodule KidseeApi.UserAnswerFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.{UserAnswer, User, Assignment}
    alias KidseeApi.{LocationFactory, UserFactory, AnswerFactory, AssignmentFactory}

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AnswerView

    def user_answer_factory do
      %UserAnswer{
        user:           UserFactory.insert(:user),
        answer:         AnswerFactory.insert(:answer),
        assignment:     AssignmentFactory.insert(:assignment),
        correct_answer: true
      }

    end

    def invalid_user_answer_factory do
      %UserAnswer{build(:user_answer) |
        user: nil
    }
    end

    def jsonapi_user_answer_factory do
      json_api_params_for(:user_answer)
    end
  end