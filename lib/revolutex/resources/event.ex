defmodule Revolutex.Event do
  @moduledoc "https://revolutdev.github.io/business-api/#transaction-created-event"
  @type t :: %__MODULE__{}

  defstruct [
    :event,
    :timestamp,
    :data
  ]
end
