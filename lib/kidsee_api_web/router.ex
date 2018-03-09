defmodule KidseeApiWeb.Router do
  use KidseeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :unauthorized do
    plug :fetch_session
  end

  pipeline :authorized do
    plug :fetch_session
    plug Guardian.Plug.Pipeline, module: GuardianDemo.Guardian,
      error_handler: GuardianDemo.AuthErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/api", KidseeApiWeb do
    resources "/users", UserController, except: [:new, :edit]
    pipe_through :api

    scope "/users" do
      scope "/" do
        pipe_through :unauthorized
  
        post "/sign-in", UserController, :sign_in

        scope "/" do
          pipe_through :authorized
    
          post "/sign-out", UserController, :sign_out
          get "/me", UserController, :show_loggend_in
        end
      end
  end
end
end
