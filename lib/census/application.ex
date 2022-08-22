defmodule Census.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Census.Repo,

      # Start the EventStore
      Census.EventStore,
      # Start the Telemetry supervisor
      CensusWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Census.PubSub},
      # Start the Endpoint (http/https)
      CensusWeb.Endpoint
      # Start a worker by calling: Census.Worker.start_link(arg)
      # {Census.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Census.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CensusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
