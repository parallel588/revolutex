defmodule Revolutex.Api.Webhook do
  @moduledoc """
  https://revolutdev.github.io/business-api/#setting-up-a-web-hook
  """

  alias Revolutex.Error

  @endpoint "/webhook"

  def setup(client, url) do
    with {:ok, _} <- Tesla.post(client, @endpoint, %{url: url}) do
      {:ok}
    else
      error -> {:error, Error.new(error)}
    end
  end

  def delete(client) do
    with {:ok, _} <- Tesla.delete(client, @endpoint) do
      {:ok}
    else
      error -> {:error, Error.new(error)}
    end
  end
end
