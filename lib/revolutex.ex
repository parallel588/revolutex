defmodule Revolutex do
  @moduledoc """
  A HTTP client for Revolut.
  """

  alias Revolutex.Application
  alias Revolutex.Config
  alias Tesla.Middleware

  @typedoc """
  A hex-encoded UUID string.
  """
  @type id :: <<_::288>>

  def client(token, opts \\ []) do
    middleware = [
      {Middleware.BaseUrl, api_endpoint(opts)},
      Middleware.JSON,
      {Middleware.Headers, [{"authorization", "Bearer " <> token}]}
    ]

    adapter = {Config.resolve(:adapter), hackney_opts(opts)}
    Tesla.client(middleware, adapter)
  end

  defp hackney_opts(opts) do
    opts
    |> Keyword.get(:pool_options, Config.resolve(:pool_options, []))
    |> Keyword.merge(pool: Application.hackney_pool_name())
  end

  defp api_endpoint(opts) do
    mode = Keyword.get(opts, :mode, Config.resolve(:mode, :sandbox))

    case mode do
      :production -> Config.resolve(:production_api_endpoint)
      _ -> Config.resolve(:sandbox_api_endpoint)
    end
  end
end
