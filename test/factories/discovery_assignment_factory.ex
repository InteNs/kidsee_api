defmodule KidseeApi.DiscoveryAssignmentFactory do
  use ExMachina.Ecto, repo: KidseeApi.Repo

  alias KidseeApi.Schemas.DiscoveryAssignment
  alias KidseeApi.{DiscoveryFactory, AssignmentFactory}

  use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.AnswerView

  def discovery_assignment_factory do
    %DiscoveryAssignment{
      discovery:  DiscoveryFactory.insert(:discovery),
      assignment: AssignmentFactory.insert(:assignment),
      name: Faker.Name.name(),
      sort_order: sequence(:sort_order, &(&1))
    }

  end

  def invalid_discovery_assignment_factory do
    %DiscoveryAssignment{build(:discovery_assignment) |
      discovery: nil
  }
  end

  def jsonapi_discovery_assignment_factory do
    json_api_params_for(:discovery_assignment)
  end
end
