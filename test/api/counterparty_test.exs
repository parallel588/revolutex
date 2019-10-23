defmodule Revolutex.Api.CounterpartyTest do
  use ExUnit.Case
  import Tesla.Mock

  alias Revolutex.Counterparty
  alias Revolutex.Api.Counterparty, as: ApiCounterparty
  alias Revolutex.Util

  @endpoint "https://sandbox-b2b.revolut.com/api/1.0"
  setup do
    mock(fn
      %{method: :get, url: @endpoint <> "/counterparties"} ->
        json(Helper.load_fixture("counterparties.json"))

      %{
        method: :get,
        url: @endpoint <> "/counterparty/ce851ec3-e018-47e8-894d-089fe8c6b6c8"
      } ->
        json(Helper.load_fixture("counterparty.json"))
    end)

    :ok
  end

  test "retrives counterparties" do
    {:ok, res} = ApiCounterparty.retrieves(Helper.client())

    counterparties =
      Helper.load_fixture("counterparties.json")
      |> Enum.map(&struct(Counterparty, Util.atomize_keys(&1)))

    assert res == counterparties
  end

  test "retrive a counterparty" do
    {:ok, res} =
      ApiCounterparty.retrieve(
        Helper.client(),
        "ce851ec3-e018-47e8-894d-089fe8c6b6c8"
      )

    counterparty =
      Counterparty
      |> struct(Util.atomize_keys(Helper.load_fixture("counterparty.json")))

    assert res == counterparty
  end
end
