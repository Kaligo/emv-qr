# frozen_string_literal: true

require_relative "emv_qr/version"

require_relative "emv_qr/schema"
require_relative "emv_qr/encode"

module EmvQr
  def encode(data)
    Encode.new.(data)
  end
  module_function :encode
end
