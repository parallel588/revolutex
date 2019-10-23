defmodule Revolutex.Account do
  @moduledoc """
  Revolut account objects.
  """

  @type t :: %__MODULE__{}

  defstruct [
    # the account ID UUID
    :id,
    # the account name Text
    :name,
    # the available balance Decimal
    :balance,
    # the account currency 3-letter ISO currency code
    :currency,
    # the account state, one of active, inactive Text
    :state,
    # determines if the account is visible to other businesses on Revolut	Boolean
    :public,
    # the instant when the account was created ISO date/time
    :created_at,
    # the instant when the account was last updated ISO date/time]
    :updated_at
  ]
end
