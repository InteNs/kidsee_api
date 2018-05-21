defmodule KidseeApiWeb.Router do
  use KidseeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    # plug JaSerializer.ContentTypeNegotiation
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

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :kidsee_api, swagger_file: "swagger.json"
  end

  scope "/api", KidseeApiWeb do
    pipe_through [:api, :auth]
    resources "/assignments", AssignmentController, only: [:index, :create, :update, :show, :delete]
    resources "/assignment-types", AssignmentTypeController, only: [:index, :create, :update, :show, :delete]
    resources "/locations", LocationController, only: [:index, :create, :update, :show, :delete]
    resources "/ratings", RatingController, only: [:index, :create, :update, :show, :delete]
    resources "/location-types", LocationTypeController, only: [:index, :create, :update, :show, :delete]
    resources "/statuses", StatusController, only: [:index, :create, :update, :show, :delete]
    resources "/content-types", ContentTypeController, only: [:index, :create, :update, :show, :delete]
    resources "/themes", ThemeController, only: [:index, :create, :update, :show, :delete] do
      resources "/posts", PostController, only: [:index]
    end
    resources "/posts", PostController, only: [:index, :create, :update, :show, :delete]
    resources "/comments", CommentController, only: [:index, :create, :update, :show, :delete]
    resources "/users", UserController, only: [:index, :update, :show, :delete]
    patch "/password-update/:id", PasswordController, :update
    post "/password-reset", PasswordController, :reset

  end

  def swagger_info do
  %{
    info: %{
      version: "1.0",
      title: "Kidsee Api",
      host: "174.138.7.193"
    }
  }
  end
end
