defmodule KidseeApiWeb.Router do
  use KidseeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KidseeApiWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
  end
end
