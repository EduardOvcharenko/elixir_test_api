defmodule TestApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias TestApi.Cache.Cache

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TestApi.Repo,
      # Start the Telemetry supervisor
      TestApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestApi.PubSub},
      # Start the Endpoint (http/https)
      TestApiWeb.Endpoint
      # Start a worker by calling: TestApi.Worker.start_link(arg)
      # {TestApi.Worker, arg}
    ]

    Cache.start(:car_brand_cache, [:set, :public, :named_table])
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TestApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
