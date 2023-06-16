defmodule Archive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ArchiveWeb.Telemetry,
      # Start the Ecto repository
      Archive.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Archive.PubSub},
      # Start Finch
      {Finch, name: Archive.Finch},
      # Start the Endpoint (http/https)
      ArchiveWeb.Endpoint
      # Start a worker by calling: Archive.Worker.start_link(arg)
      # {Archive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Archive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArchiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
