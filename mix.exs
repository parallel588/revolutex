defmodule Revolutex.MixProject do
  use Mix.Project

  def project do
    [
      app: :revolutex,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_options: [warnings_as_errors: true],
      dialyzer: [
        plt_add_apps: [:mix],
        plt_file: {:no_warn, "priv/plts/revolutex.plt"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:hackney, :logger],
      env: env(),
      mod: {Revolutex.Application, []}
    ]
  end

  defp env() do
    revolut_env = [
      sandbox_api_endpoint: "https://sandbox-b2b.revolut.com/api/1.0",
      production_api_endpoint: "https://b2b.revolut.com/api/1.0",
      pool_options: [
        timeout: 5_000,
        max_connections: 10
      ],
      use_connection_pool: true,
      adapter: Tesla.Adapter.Hackney
    ]

    if Mix.env() == :test do
      Keyword.put(revolut_env, :adapter, Tesla.Mock)
    else
      revolut_env
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.2"},
      {:hackney, "~> 1.15"},
      {:jason, "~> 1.1"},
      {:plug, "~> 1.7"},
      {:dialyxir, "> 0.0.0", only: [:dev], runtime: false},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
