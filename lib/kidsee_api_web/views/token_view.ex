defmodule KidseeApiWeb.TokenView do
  use KidseeApiWeb, :view

  def render("token.json-api", %{token: token, user: user}) do
    %{meta: %{token: token, id: user.id}}
  end
end
