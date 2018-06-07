defmodule KidseeApi.DiscoveryFactory do
  use ExMachina.Ecto, repo: KidseeApi.Repo

  alias KidseeApi.Schemas.Discovery

  use KidseeApi.JsonApiParamsStrategy, view: KidseeApiWeb.LocationView

  def discovery_factory do
    %Discovery{
      name: Faker.Name.name(),
      assignments: []
    }
  end

  def invalid_discovery_factory do
    %Discovery{build(:discovery) |
      name: nil
    }
  end

  def jsonapi_discovery_factory do
    json_api_params_for(:discovery)
  end
end
