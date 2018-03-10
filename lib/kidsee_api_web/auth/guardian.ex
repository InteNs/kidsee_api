defmodule KidseeApiWeb.Guardian do
  use Guardian, otp_app: :kidsee_api

  alias KidseeApi.Accounts

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    {:ok, Accounts.get_user!(id)}
  end
end
