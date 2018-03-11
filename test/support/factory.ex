defmodule KidseeApi.Factory do
  defmacro __using__(_) do
    quote do
      import KidseeApi.UserFactory
    end
  end
end
