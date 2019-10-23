defmodule Revolutex.Counterparty do
  @moduledoc "https://revolutdev.github.io/business-api/#counterparties"

  @type t :: %__MODULE__{
          # id the ID of the counterparty UUID
          id: Revolutex.id(),
          # name the name of the counterparty Text
          name: String.t(),
          # phone the phone number of the counterparty Text
          phone: String.t(),
          # profile_type the type of the Revolut profile, business or personal Text
          profile_type: String.t(),
          # bank_country the country of the bank 2-letter ISO code
          bank_country: String.t(),
          # state the state of the counterparty, one of created, deleted Text
          state: String.t(),
          # created_at the instant when the counterparty was created ISO date/time
          created_at: String.t(),
          # updated_at the instant when the counterparty was last updated ISO date/time
          updated_at: String.t(),

          # accounts the list of public accounts of this counterparty JSON array
          accounts: list(account())
        }

  @type account :: %{
          # id the ID of a counterparty's account UUID
          id: Revolutex.id(),
          # currency the currency of a counterparty's account 3-letter ISO currency code
          currency: String.t(),
          # type the type of account, revolut or external Text
          type: String.t(),
          # account_no bank account number Text
          account_no: String.t(),
          # iban IBAN Text
          iban: String.t(),
          # sort_code sort code Text
          sort_code: String.t(),
          # routing_number routing transit number Text
          routing_number: String.t(),
          # bic BIC Text
          bic: String.t(),
          # recipient_charges indicates the possibility of the recipient charges
          recipient_charges: String.t()
        }

  defstruct [
    :id,
    :name,
    :phone,
    :profile_type,
    :bank_country,
    :state,
    :created_at,
    :updated_at,
    :accounts
  ]
end
