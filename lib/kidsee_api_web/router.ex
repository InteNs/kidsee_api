defmodule KidseeApiWeb.Router do
  use KidseeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :auth do
    plug KidseeApiWeb.Guardian.AuthPipeline
  end

  scope "/api", KidseeApiWeb do
    pipe_through :api

    resources "/users", UserController, only: [:options, :create]
    post "/tokens", TokenController, :create
  end

  scope "/api", KidseeApiWeb do
    pipe_through [:api, :auth]
    resources "/post-statuses", PostStatusController, only: [:index, :create, :update, :show, :delete]
    resources "/content-types", ContentTypeController, only: [:index, :create, :update, :show, :delete]
    resources "/posts", PostController, only: [:index, :create, :update, :show, :delete]
    resources "/comments", CommentController, only: [:index, :create, :update, :show, :delete]
    resources "/users", UserController, only: [:index, :update, :show, :delete]
  end
end
