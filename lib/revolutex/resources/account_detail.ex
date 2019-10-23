defmodule Revolutex.AccountDetail do
  @moduledoc """
  Revolut account detail objects.
  """

  @type t :: %__MODULE__{
          # IBAN Text
          iban: String.t(),
          # BIC Text
          bic: String.t(),
          # the account number Text
          account_no: String.t(),
          # the sort code Text
          sort_code: String.t(),
          # the routing number Text
          routing_number: String.t(),
          # the beneficiary name Text
          beneficiary: String.t(),
          # the address of the beneficiary
          beneficiary_address: address(),
          # the country of the bank Text
          bank_country: String.t(),
          # determines if this account address is pooled or unique Boolean
          pooled: boolean(),
          # the reference of the pooled account Text
          unique_reference: String.t(),
          # the list of supported schemes,
          schemes: list(String.t()),
          # possible values: chaps, bacs,  faster_payments, sepa, swift, ach	Text
          # the inbound transfer time estimate
          estimated_time: estimated_time()
        }

  @type address :: %{
          region: String.t(),
          city: String.t(),
          country: String.t(),
          street_line1: String.t(),
          street_line2: String.t(),
          postcode: String.t()
        }
  @type estimated_time :: %{
          # the unit of the inbound transfer time estimate,
          unit: String.t(),
          # possible values:  days, hours	Text
          # the maximum estimate Decimal
          max: float(),
          # the minimum estimate Decimal
          min: float()
        }

  defstruct [
    :iban,
    :bic,
    :account_no,
    :sort_code,
    :routing_number,
    :beneficiary,
    :beneficiary_address,
    :bank_country,
    :pooled,
    :unique_reference,
    :schemes,
    :estimated_time
  ]
end
