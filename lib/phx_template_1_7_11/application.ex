defmodule PhxTemplate1711.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxTemplate1711Web.Telemetry,
      PhxTemplate1711.Repo,
      {DNSCluster,
       query: Application.get_env(:phx_template_1_7_11, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxTemplate1711.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxTemplate1711.Finch},
      # Start a worker by calling: PhxTemplate1711.Worker.start_link(arg)
      # {PhxTemplate1711.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxTemplate1711Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxTemplate1711.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxTemplate1711Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
