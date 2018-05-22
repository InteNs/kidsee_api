defmodule KidseeApi.AnswerTypeFactory do
    use ExMachina.Ecto, repo: KidseeApi.Repo

    alias KidseeApi.Schemas.AnswerType

    use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AnswerTypeView

    def answer_type_factory do
      %AnswerType{
        name:         "Example name",
      }
    end

    def invalid_answer_type_factory do
      %AnswerType{build(:answer_type) |
        name: nil
    }
    end

    def jsonapi_answer_type_factory do
      json_api_params_for(:answer_type)
    end
  end