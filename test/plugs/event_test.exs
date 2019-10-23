defmodule Revolutex.Plugs.EventTest do
  #  use Plug.Test
  use ExUnit.Case, async: true

  @transaction_state_changed %{
    "event" => "TransactionStateChanged",
    "timestamp" => "2017-12-06T12:21:49.865Z",
    "data" => %{
      "id" => "9a6434d8-3581-4faa-988b-48875e785be7",
      "old_state" => "pending",
      "new_state" => "reverted"
    }
  }

  test "load event" do
    res =
      %Plug.Conn{params: @transaction_state_changed}
      |> Revolutex.Plugs.Event.call([])

    assert res.assigns[:event] == %Revolutex.Event{
             data: %{
               id: "9a6434d8-3581-4faa-988b-48875e785be7",
               new_state: "reverted",
               old_state: "pending"
             },
             event: "TransactionStateChanged",
             timestamp: "2017-12-06T12:21:49.865Z"
           }
  end
end
