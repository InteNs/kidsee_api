defmodule KidseeApiWeb.TokenView do
  use KidseeApiWeb, :view

  def render("token.json-api", %{token: token}) do
    %{meta: %{token: token}}
  end
end
