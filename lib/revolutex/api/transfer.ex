defmodule Revolutex.Api.Transfer do
  @moduledoc """
  The module represents ability  transfers between accounts of the business with the same currency.

  Revolut API reference: https://revolutdev.github.io/business-api/#transfers
  """

  alias Revolutex.Error
  alias Revolutex.Transaction
  alias Revolutex.Util
  alias Tesla.Env

  @endpoint "/transfer"

  @doc """
  Creates transfer.
  """
  @spec create(Tesla.Client.t(), attrs) :: {:ok, Transaction.t()} | {:error, Error.t()}
        when attrs: %{
               required(:request_id) => String.t(),
               required(:source_account_id) => Revolutex.id(),
               required(:target_account_id) => Revolutex.id(),
               required(:amount) => float(),
               required(:currency) => String.t(),
               optional(:reference) => String.t()
             }
  def create(client, attrs) do
    with {:ok, %Env{body: raw_attrs}} <- Tesla.post(client, @endpoint, attrs),
         attrs <- Util.atomize_keys(raw_attrs) do
      {:ok, struct(Transaction, attrs)}
    else
      error -> {:error, Error.new(error)}
    end
  end
end
