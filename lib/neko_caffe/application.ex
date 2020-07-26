defmodule NekoCaffe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      NekoCaffe.Repo,
      # Start the Telemetry supervisor
      NekoCaffeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: NekoCaffe.PubSub},
      # Start the Endpoint (http/https)
      NekoCaffeWeb.Endpoint
      # Start a worker by calling: NekoCaffe.Worker.start_link(arg)
      # {NekoCaffe.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NekoCaffe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NekoCaffeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
