defmodule Form.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FormWeb.Telemetry,
      Form.Repo,
      {DNSCluster, query: Application.get_env(:form, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Form.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Form.Finch},
      # Start a worker by calling: Form.Worker.start_link(arg)
      # {Form.Worker, arg},
      # Start to serve requests, typically the last entry
      FormWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Form.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FormWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
