defmodule Revolutex.Api.AccountTest do
  use ExUnit.Case
  import Tesla.Mock

  alias Revolutex.Account
  alias Revolutex.AccountDetail
  alias Revolutex.Api.Account, as: ApiAccount
  alias Revolutex.Util

  @endpoint "https://sandbox-b2b.revolut.com/api/1.0"
  setup do
    mock(fn
      %{method: :get, url: @endpoint <> "/accounts/a4e35949-465d-4f05-beb1-1c586cf822ce"} ->
        json(Helper.load_fixture("account.json"))

      %{
        method: :get,
        url: @endpoint <> "/accounts/a4e35949-465d-4f05-beb1-1c586cf822ce/bank-details"
      } ->
        json(Helper.load_fixture("account_details.json"))

      %{method: :get, url: @endpoint <> "/accounts"} ->
        json(Helper.load_fixture("accounts.json"))
    end)

    :ok
  end

  test "retrives accounts" do
    {:ok, res} = ApiAccount.retrieves(Helper.client())

    accounts =
      Helper.load_fixture("accounts.json")
      |> Enum.map(&struct(Account, Util.atomize_keys(&1)))

    assert res == accounts
  end

  test "retrive an account" do
    {:ok, res} =
      ApiAccount.retrieve(
        Helper.client(),
        "a4e35949-465d-4f05-beb1-1c586cf822ce"
      )

    account =
      Account
      |> struct(Util.atomize_keys(Helper.load_fixture("account.json")))

    assert res == account
  end

  test "retrive an account details" do
    {:ok, res} =
      ApiAccount.retrieve_details(
        Helper.client(),
        "a4e35949-465d-4f05-beb1-1c586cf822ce"
      )

    account_details =
      Helper.load_fixture("account_details.json")
      |> Enum.map(&struct(AccountDetail, Util.atomize_keys(&1)))

    assert res == account_details
  end
end
