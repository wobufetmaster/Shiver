defmodule Shiver.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShiverWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:shiver, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Shiver.PubSub},
      # Start a worker by calling: Shiver.Worker.start_link(arg)
      # {Shiver.Worker, arg},
      # Start to serve requests, typically the last entry
      ShiverWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shiver.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShiverWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
