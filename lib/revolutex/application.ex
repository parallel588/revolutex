defmodule Revolutex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias Revolutex.Config
  @hackney_pool_name :revolutex_pool

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      :hackney_pool.child_spec(@hackney_pool_name, get_pool_options())
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Revolutex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def hackney_pool_name, do: @hackney_pool_name

  defp get_pool_options do
    Config.resolve(:pool_options, [])
  end
end
