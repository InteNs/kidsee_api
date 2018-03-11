defmodule KidseeApi.JsonApiParamsStrategy do
  use ExMachina.Strategy, function_name: :json_api_params_for

  def handle_json_api_params_for(record, opts) do
    Map.fetch!(opts, :factory_module)
    |> factory_to_view
    |> JaSerializer.format(record)
  end

  defp factory_to_view(factory) do
    name = factory |> Module.split |> List.last |> String.replace("Factory", "")
    Module.concat(KidseeApiWeb, "#{name}View")
  end
end
