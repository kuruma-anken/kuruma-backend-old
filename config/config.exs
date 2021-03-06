# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kuruma,
  ecto_repos: [Kuruma.Repo]

# Configures the endpoint
config :kuruma, KurumaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3Bi/4Shw9JUqGDeIkEmtq+tUV++qTNrpzfFJUz+QcqUL7mOWaNmOKYZgGWKJH9Xn",
  render_errors: [view: KurumaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Kuruma.PubSub,
  live_view: [signing_salt: "AXPlPOws"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :arc,
  storage: Arc.Storage.S3,
  bucket: "kuruma-staging-uploads"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
