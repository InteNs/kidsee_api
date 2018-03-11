defmodule KidseeApi.Factory do
  use ExMachina.Ecto, repo: KidseeApi.Repo

  use KidseeApi.UserFactory
end
