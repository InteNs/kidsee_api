
defmodule KidseeApi.Schemas.ThemeLocation do
    use KidseeApi.Schema
    alias KidseeApi.Schemas.{Location, Theme}

    schema "theme_location" do
      belongs_to :theme, Theme
      belongs_to :location, Location
      timestamps()
    end

    def preload(query), do: query
  end
