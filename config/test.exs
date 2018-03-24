use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kidsee_api, KidseeApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :kidsee_api, KidseeApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "kidsee_api_test",
  hostname: "174.138.7.193",
  pool: Ecto.Adapters.SQL.Sandbox
