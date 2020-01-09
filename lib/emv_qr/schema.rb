# frozen_string_literal: true

require "dry-schema"

Dry::Schema.load_extensions(:hints)

module EmvQr
  # This class defines a schema for the input format expected by the
  # EmvQr encoder.
  #
  class Schema < Dry::Schema::Params
    define do
      # Indicates whether the data in the QR Code is static or dynamic.
      # Static shall be used when the same QR Code is shown for more than
      # one transaction, and dynamic shall be used when a new QR Code is
      # shown for each transaction.
      #
      optional(:mode).filled(:string, included_in?: %w[static dynamic])

      required(:merchant).hash do
        # Merchant category code (MCC) is a four digit code, as defined in
        # the ISO 18245 standard.
        #
        required(:category_code).filled(:string, size?: 4)

        # Merchant country code is a two letter (alpha-2) code, as defined
        # in the ISO 3166-1 standard.
        #
        required(:country_code).filled(:string, size?: 2)

        required(:name).filled(:string, max_size?: 25)
        required(:city).filled(:string, max_size?: 15)
        optional(:postal_code).filled(:string, max_size?: 10)
      end

      required(:transaction).hash do
        # Transaction currency is a three letter (alphabetic) code, as
        # defined in the ISO 4217 standard.
        #
        # Note: EMV QR requires the numeric code, but we handle that
        #       mapping internally as the alphabetic code is easier for
        #       humans to work with.
        #
        required(:currency).filled(:string, size?: 3)

        # Transaction number is a decimal amount. It is conditional, and
        # when omitted, indicates to the application reading the QR Code
        # that the user needs to be prompted to input an amount.
        #
        optional(:amount).filled(:float)

        # A tip or convenience fee can be expressed as either a fixed
        # amount or as a percentage of the transaction amount.
        #
        optional(:convenience_fee).hash do
          optional(:fixed).filled(:float)
          optional(:percentage).filled(:float)
        end
      end

      # Merchant information can optionally be provided in an alternate
      # language.
      #
      optional(:translation).hash do
        # Translation language code is a two letter (alpha-2) code, as
        # defined in the ISO 639-1 standard.
        #
        required(:language_code).filled(:string, size?: 2)

        required(:merchant_name).filled(:string, max_size?: 25)
        optional(:merchant_city).filled(:string, max_size?: 15)
      end

      optional(:additional).hash do
        # Additional bill number is typically used when the QR Code is
        # used for bill payment. It can be provided by the merchant, or
        # used as an indication for the application reading the QR Code
        # to prompt the user to input a bill number.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:bill_number).filled(:string, max_size?: 25)

        # Additional mobile number is typically used when the QR Code
        # is used for mobile top-up. It can be provided by the merchant,
        # or used as an indication for the application reading the QR
        # Code to prompt the user to input a mobile number.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:mobile_number).filled(:string, max_size?: 25)

        # Additional store label is a distinct value associated with a
        # store. It can be provided by the merchant, or used as an
        # indication for the application reading the QR Code to prompt
        # the user to input a store label.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:store_label).filled(:string, max_size?: 25)

        # Additional loyalty number is typically a loyalty card number.
        # It can be provided by the merchant, or used as an indication
        # for the application reading the QR Code to prompt the user to
        # input a loyalty number.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:loyalty_number).filled(:string, max_size?: 25)

        # Additional reference label is any value, as defined by the
        # merchant, in order to identify the transaction. It can be
        # provided by the merchant, or used as an indication for the
        # application reading the QR Code to prompt the user to input
        # a reference label.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:reference_label).filled(:string, max_size?: 25)

        # Additional customer label is any value identifying a specific
        # customer. It can be provided by the merchant, or used as an
        # indication for the application reading the QR Code to prompt
        # the user to input a customer label.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:customer_label).filled(:string, max_size?: 25)

        # Additional terminal label is any value, as defined by the
        # merchant, in order to identify a terminal in the store. It
        # can be provided by the merchant, or used as an indication
        # for the application reading the QR Code to prompt the user
        # to input a terminal label.
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:terminal_label).filled(:string, max_size?: 25)

        # Additional purpose is any value used to indicate the purpose
        # of the transaction. It can be provided by the merchant, or
        # used as an indication for the application reading the QR Code
        # to prompt the user to input a purpose.
        #
        # Example: Data Package (10Gb)
        #
        # Note: To indicate a prompt, use the value: ***
        #
        optional(:purpose).filled(:string, max_size?: 25)
      end

      # Data request flags can be used to indicate that the application
      # reading the QR Code needs to provide additional information in
      # order to complete the transaction.
      #
      # Note: The application should provide this data without prompting
      #       the consumer unnecessarily. Thus, the consumer will likely
      #       not be asked to fill this in.
      #
      optional(:data_request).hash do
        optional(:address).filled(:bool)
        optional(:mobile_number).filled(:bool)
        optional(:email_address).filled(:bool)
      end
    end
  end
end
