# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chirplive,
  ecto_repos: [Chirplive.Repo]

# Configures the endpoint
config :chirplive, ChirpliveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5tG4ebsq5a/WmXdpVYvuj+K6N6xNg74ipemR/8IWu8wA2ZkqZsSBZba9If83CoMl",
  render_errors: [view: ChirpliveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chirplive.PubSub,
  live_view: [signing_salt: "NgbUNQO7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :chirplive, :pow,
  user: Chirplive.Users.User,
  repo: Chirplive.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
