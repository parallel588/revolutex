defmodule Revolutex.Api.Payment do
  @moduledoc "https://revolutdev.github.io/business-api/#payments"

  alias Revolutex.Error
  alias Revolutex.Transaction
  alias Revolutex.Util
  alias Tesla.Env

  @doc "https://revolutdev.github.io/business-api/#create-payment"
  @spec pay(Tesla.Client.t(), attrs) :: {:ok, Transaction.t()} | {:error, Error.t()}
        when attrs: %{
               required(:request_id) => String.t(),
               required(:account_id) => Revolutex.id(),
               required(:receiver) => %{
                 required(:counterparty_id) => Revolutex.id(),
                 required(:account_id) => Revolutex.id()
               },
               required(:amount) => float(),
               required(:currency) => String.t(),
               optional(:reference) => String.t()
             }
  def pay(client, attrs) do
    with {:ok, %Env{body: raw_attrs}} <- Tesla.post(client, "/pay", attrs),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, struct(Transaction, attrs)}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @doc "https://revolutdev.github.io/business-api/#cancel-payment"
  @spec cancel(Tesla.Client.t(), Revolutex.id()) :: {:ok} | {:error, Error.t()}
  def cancel(client, id) do
    with {:ok, _} <- Tesla.delete(client, "/transaction/#{id}") do
      {:ok}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @doc "https://revolutdev.github.io/business-api/#get-transaction"
  @spec get_transaction(Tesla.Client.t(), Revolutex.id(), Keyword.t()) ::
          {:ok, Transaction.t()} | {:error, Error.t()}
  def get_transaction(client, id, opts \\ []) do
    endpoint =
      case Keyword.get(opts, :type) do
        :request_id -> "/transaction/#{id}?id_type=request_id"
        _ -> "/transaction/#{id}"
      end

    with {:ok, %Env{body: raw_attrs, status: 200}} <- Tesla.get(client, endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, struct(Transaction, attrs)}
    else
      error -> {:error, Error.new(error)}
    end
  end

  @doc "https://revolutdev.github.io/business-api/#get-transactions"
  @spec get_transactions(Tesla.Client.t()) :: {:ok, list(Transaction.t())} | {:error, Error.t()}
  def get_transactions(client) do
    with endpoint <- "/transactions",
         {:ok, %Env{body: raw_attrs, status: 200}} <- Tesla.get(client, endpoint),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, Enum.map(attrs, &struct(Transaction, &1))}
    else
      error -> {:error, Error.new(error)}
    end
  end
end
