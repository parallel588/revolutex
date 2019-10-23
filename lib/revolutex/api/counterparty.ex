defmodule Revolutex.Api.Counterparty do
  @moduledoc "https://revolutdev.github.io/business-api/#counterparties"

  alias Revolutex.Counterparty, as: ResourceCounterparty
  alias Revolutex.Error
  alias Revolutex.Util
  alias Tesla.Env

  @endpoint "/counterparty"
  @plural_endpoint "/counterparties"

  @doc "https://revolutdev.github.io/business-api/#counterparties"
  @spec create(Tesla.Client.t(), map()) :: {:ok, ResourceCounterparty.t()} | {:error, Error.t()}
  def create(client, attrs) do
    with {:ok, %Env{body: raw_attrs}} <- Tesla.post(client, @endpoint, attrs),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, struct(ResourceCounterparty, attrs)}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @spec delete(Tesla.Client.t(), Revolutex.id()) :: {:ok} | {:error, Error.t()}
  def delete(client, id) do
    with {:ok, _} <- Tesla.delete(client, @endpoint <> "/#{id}") do
      {:ok}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @spec retrieves(Tesla.Client.t()) ::
  {:ok, list(ResourceCounterparty.t())} | {:error, Error.t()}
  def retrieves(client) do
    with {:ok, %Env{body: raw_attrs, status: 200}} <- Tesla.get(client, @plural_endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, Enum.map(attrs, &struct(ResourceCounterparty, &1))}
    else
      {:ok, %Env{status: 404}} -> {:ok, []}
      error -> {:error, Error.new(error)}
    end
  end

  @spec retrieve(Tesla.Client.t(), Revolutex.id()) ::
          {:ok, ResourceCounterparty.t()} | {:error, Error.t()}
  def retrieve(client, id) do
    with endpoint <- @endpoint <> "/#{id}",
         {:ok, %Env{body: raw_attrs}} <- Tesla.get(client, endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, struct(ResourceCounterparty, attrs)}
    else
      error -> {:error, Error.new(error)}
    end
  end
end
