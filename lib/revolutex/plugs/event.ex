defmodule Revolutex.Plugs.Event do
  @moduledoc "load params to event struct"

  import Plug.Conn

  alias Revolutex.Event
  alias Revolutex.Util

  @events ["TransactionCreated", "TransactionStateChanged"]

  def init(opts \\ []), do: opts

  def call(%Plug.Conn{params: %{"event" => event_type} = params} = conn, _)
      when event_type in @events do
    event = struct(Event, Util.atomize_keys(params))
    assign(conn, :event, event)
  end

  def call(conn, _), do: conn
end
