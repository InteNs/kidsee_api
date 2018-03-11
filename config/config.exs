# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kidsee_api,
  ecto_repos: [KidseeApi.Repo]

# Configures the endpoint
config :kidsee_api, KidseeApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CUykr1kJq51xNXBsu1h6aoseOeoNT5i/Tet0zKvFs8u5x5E+loWqYXKCc3LVeRHh",
  render_errors: [view: KidseeApiWeb.ErrorView, accepts: ~w(json)],
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
