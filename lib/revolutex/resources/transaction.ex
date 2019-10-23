defmodule Revolutex.Transaction do
  @moduledoc "https://revolutdev.github.io/business-api/#get-transaction"

  @type t :: %__MODULE__{
          # the ID of transaction UUID
          id: Revolutex.id(),
          # the transaction type,
          type: String.t(),
          # one of atm, card_payment, card_refund,  card_chargeback,
          # card_credit, exchange, transfer, loan, fee,  refund,
          # topup, topup_return, tax, tax_refund Text
          # the client provided request ID Text
          request_id: String.t(),
          # the transction state: pending, completed, declined or failed Text
          state: String.t(),
          # reason code for declined or failed transaction state Text
          reason_code: String.t(),
          # the instant when the transaction was created ISO date/time
          created_at: String.t(),
          # the instant when the transaction was last updated ISO date/time
          updated_at: String.t(),
          # the instant when the transaction was completed, mandatory for  completed state only ISO date/time
          completed_at: String.t(),
          # an optional date when the transaction was scheduled for ISO date
          scheduled_for: String.t(),
          # the merchant info (only for card payments) Object
          merchant: merchant(),
          # a user provided payment reference Text
          reference: String.t(),
          # the legs of transaction,
          legs: list(leg()),
          # there'll be 2 legs between your Revolut accounts and 1 leg in other cases Array
          # the card information (only for card payments) Object
          card: card()
        }

  @type merchant :: %{
          # the merchant name Text
          name: String.t(),
          # the merchant city Text
          city: String.t(),
          #  the merchant category code Text
          category_code: String.t(),
          #  3-letter ISO bankCountry code Text
          country: String.t()
        }

  @type leg :: %{
          # the ID of the leg UUID
          leg_id: Revolutex.id(),
          # the transaction amount Decimal
          amount: float(),
          # the transaction currency 3-letter ISO currency code
          currency: String.t(),
          # the billing amount for cross-currency payments Decimal
          bill_amount: float(),
          bill_currency: String.t(),
          # the billing currency for cross-currency payments 3-letter ISO currency code
          account_id: Revolutex.id(),
          # the ID of the account the transaction is associated with UUID
          # the counterparty
          counterparty: counterparty(),
          # the transaction leg purpose Text
          description: String.t(),
          balance: float()
          # a total balance of the account the transaction is associated with (optional) Decimal
        }

  @type counterparty :: %{
          # the counterparty ID UUID
          id: Revolutex.id(),
          # the counterparty account ID UUID
          account_id: Revolutex.id(),
          # the type of account: self, revolut, external Text
          type: String.t()
        }

  @type card :: %{
          # the masked card number Text
          card_number: String.t(),
          # the cardholder's first name Text
          first_name: String.t(),
          # the cardholder's last name Text
          last_name: String.t(),
          # the cardholder's phone number Text
          phone: String.t()
        }

  defstruct [
    :id,
    :type,
    :request_id,
    :state,
    :reason_code,
    :created_at,
    :updated_at,
    :completed_at,
    :scheduled_for,
    :merchant,
    :reference,
    :legs,
    :card
  ]
end
