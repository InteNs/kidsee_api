defmodule KidseeApiWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :kidsee_api,
                              module: KidseeApiWeb.Guardian,
                              error_handler: KidseeApiWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
end
