# frozen_string_literal: true

require "dry-transaction"

module EmvQr
  # The EMV QR specification limits the payload to a length of
  # 512 characters, but also states the length should be reduced
  # proportionally when using multi-byte characters. This is
  # essentially the same as saying the maximum payload size is
  # 512 bytes.
  #
  MAXIMUM_PAYLOAD_BYTE_SIZE = 512

  # Transaction that serves encapsulates the main entry point
  # of the encoder.
  #
  class Encode
    include Dry::Transaction

    step :validate_input
    step :construct_payload
    step :calculate_checksum
    step :validate_payload_size

    private

    def validate_input(input)
      Schema.new.(input).to_monad
    end

    def construct_payload(input)
      Success(input)
      # TODO: Implement
    end

    def calculate_checksum(input)
      Success(input)
      # TODO: Implement
    end

    def validate_payload_size(input)
      Success(input)
      # TODO: Implement
    end
  end
  private_constant :Encode
end
