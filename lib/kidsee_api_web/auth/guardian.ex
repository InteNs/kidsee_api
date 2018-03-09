defmodule KidseeApiWeb.Guardian do
  use Guardian, otp_app: :kidsee_api

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    {:ok, KidseeApi.Accounts.get_user!(id) }
  end
end
