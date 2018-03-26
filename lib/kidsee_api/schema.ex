defmodule KidseeApi.Schema do

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query, except: [preload: 2]
      import unquote(__MODULE__)
      alias KidseeApi.Repo
    end
  end
end
