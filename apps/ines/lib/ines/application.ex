defmodule Ines.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InesWeb.Telemetry,
      Ines.Repo,
      {DNSCluster, query: Application.get_env(:ines, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ines.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ines.Finch},
      # Start a worker by calling: Ines.Worker.start_link(arg)
      # {Ines.Worker, arg},
      # Start to serve requests, typically the last entry
      InesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ines.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
