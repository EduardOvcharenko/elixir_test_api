# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :test_api,
  ecto_repos: [TestApi.Repo]

config :test_api,
       TestApi.Repo,
       migration_primary_key: [type: :uuid]

config :test_api,
       TestApi.Schema.CarData,
       car_data_min_year: 1886,
       body_type_enum: ["sedan", "coupe", "pickup"]

# Configures the endpoint
config :test_api, TestApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SqU09grPmloj7cmD2rnk0DvKREk7RwV+wf9VqGpM1eDZ+rt0ephAwkxgYL+vXMoP",
  render_errors: [view: TestApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TestApi.PubSub,
  live_view: [signing_salt: "hVL0qo/j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
