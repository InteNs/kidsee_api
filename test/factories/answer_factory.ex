defmodule KidseeApi.AnswerFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.{Answer, AnswerType}
    alias KidseeApi.{LocationFactory, AnswerFactory, AssignmentFactory}

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AnswerView

    def answer_factory do
      %Answer{
        answer:            "Example answer",
        correct_answer:    false,
        assignment:        AssignmentFactory.insert(:assignment)
      }

    end

    def invalid_answer_factory do
      %Answer{build(:answer) |
        answer: nil
    }
    end

    def jsonapi_answer_factory do
      json_api_params_for(:answer)
    end
  end