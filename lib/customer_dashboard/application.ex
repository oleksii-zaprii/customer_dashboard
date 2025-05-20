defmodule CustomerDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CustomerDashboardWeb.Telemetry,
      CustomerDashboard.Repo,
      {DNSCluster,
       query: Application.get_env(:customer_dashboard, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CustomerDashboard.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CustomerDashboard.Finch},
      # Start a worker by calling: CustomerDashboard.Worker.start_link(arg)
      # {CustomerDashboard.Worker, arg},
      # Start to serve requests, typically the last entry
      CustomerDashboardWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CustomerDashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CustomerDashboardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
