defmodule KidseeApiWeb.Router do
  use KidseeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug KidseeApiWeb.Guardian.AuthPipeline
  end

  scope "/api", KidseeApiWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    post "/users/sign-in", UserController, :sign_in
  end

  scope "/api", KidseeApiWeb do
    pipe_through [:api, :auth]

    resources "/users", UserController, only: [:index, :update, :show, :delete]
  end
end
