defmodule KidseeApi.JsonApiParamsStrategy do
  use ExMachina.Strategy, function_name: :json_api_params_for

  def handle_json_api_params_for(record, opts) do
    Map.fetch!(opts, :factory_module)
    |> factory_to_view
    |> JaSerializer.format(record)
    |> remove_empty_relationships
  end

  defp factory_to_view(factory) do
    name = factory |> Module.split |> List.last |> String.replace("Factory", "")
    Module.concat(KidseeApiWeb, "#{name}View")
  end

  defp remove_empty_relationships(data) do
    update_in(data["data"]["relationships"], fn (relationships) ->
      case relationships do
        nil -> nil
        _ -> Enum.filter(relationships, fn {_, val} -> val != %{} end)
      end
    end)
  end
end
