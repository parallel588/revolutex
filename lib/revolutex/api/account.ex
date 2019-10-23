defmodule Revolutex.Api.Account do
  @moduledoc """
  Work with Revolut account objects.

  You can:

  - Retrieves your accounts
  - Retrieves one of your accounts by ID
  - Retrieves individual account details

  Revolut API reference: https://revolutdev.github.io/business-api/#accounts
  """

  alias Revolutex.Account
  alias Revolutex.AccountDetail
  alias Revolutex.Error
  alias Revolutex.Util
  alias Tesla.Env

  @plural_endpoint "/accounts"

  @doc """
  Retrieves a your account.
  """
  @spec retrieves(Tesla.Client.t()) :: {:ok, list(Account.t())} | {:error, Error.t()}
  def retrieves(client) do
    with {:ok, %Env{body: raw_attrs, status: 200}} <- Tesla.get(client, @plural_endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, Enum.map(attrs, &struct(Account, &1))}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @doc """
  Retrieve a account.
  """
  @spec retrieve(Tesla.Client.t(), Revolutex.id()) ::
          {:ok, Account.t()} | {:error, Revolutex.Error.t()}
  def retrieve(client, id) do
    with endpoint <- @plural_endpoint <> "/#{id}",
         {:ok, %Env{body: raw_attrs}} <- Tesla.get(client, endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, struct(Account, attrs)}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @doc """
  Retrieves individual account details.
  """
  @spec retrieve_details(Tesla.Client.t(), Account.t() | Revolutex.id()) ::
          {:ok, list(AccountDetail.t())} | {:error, Revolutex.Error.t()}
  def retrieve_details(client, %Account{id: id} = _),
    do: retrieve_details(client, id)

  def retrieve_details(client, id) do
    with endpoint <- @plural_endpoint <> "/#{id}/bank-details",
         {:ok, %Tesla.Env{body: raw_attrs}} <- Tesla.get(client, endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, Enum.map(attrs, &struct(AccountDetail, &1))}
    else
      error -> {:error, Error.new(error)}
    end
  end
end
