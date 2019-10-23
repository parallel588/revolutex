defmodule Revolutex.Error do
  @moduledoc false
  @type error_source :: :internal | :network | :revolut

  @type error_status ::
          :bad_request
          | :unauthorized
          | :request_failed
          | :not_found
          | :conflict
          | :too_many_requests
          | :server_error
          | :unknown_error

  @type revolut_error_type ::
          :api_connection_error
          | :api_error
          | :authentication_error
          | :card_error
          | :invalid_request_error
          | :rate_limit_error
          | :validation_error

  @type t :: %__MODULE__{
          source: error_source,
          code: error_status | revolut_error_type | :network_error,
          request_id: String.t() | nil,
          message: String.t(),
          user_message: String.t() | nil
        }

  defstruct [:source, :code, :request_id, :extra, :message, :user_message, :raw]

  def new(error) do
    struct!(__MODULE__, %{raw: error})
  end
end
