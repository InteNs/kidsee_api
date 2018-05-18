# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kidsee_api,
  ecto_repos: [KidseeApi.Repo]

config :phoenix, :format_encoders,
  "json-api": Poison

config :ja_serializer,
  pluralize_types: true

config :arc,
  storage: Arc.Storage.Local

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :kidsee_api, KidseeApi.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "in-v3.mailjet.com",
  port: 25,
  username: "9078f4d4435dc73ad41debc12b636150", #TODO set these credentials in env variables
  password: "37aa0be926e3ac89d4ea5cb9401e43c7",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

config :kidsee_api, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: KidseeApiWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: KidseeApiWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }

# Configures the endpoint
config :kidsee_api, KidseeApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CUykr1kJq51xNXBsu1h6aoseOeoNT5i/Tet0zKvFs8u5x5E+loWqYXKCc3LVeRHh",
  render_errors: [view: KidseeApiWeb.ErrorView, accepts: ~w(json-api)],
  pubsub: [name: KidseeApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :kidsee_api, KidseeApiWeb.Guardian,
  issuer: "kidsee_api",
  secret_key: "J3rFCeGVcWAkZMmzChRPQsM2hBC3P+PqYFOsVQ49qrxLsk9ucRmcQKsxjaDgnoqL"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
