# frozen_string_literal: true

module IpApi
  # Methods for converting response fields to a numeric value (to save
  # bandwidth).
  #
  # Read more: https://ip-api.com/docs/api:json#fieldsTable
  module Fields
    FIELDS = %w[
      country countryCode region regionName city zip lat lon timezone isp org
      as reverse query status message mobile proxy :empty: district continent
      continentCode asname currency hosting offset
    ].freeze

    # Gets the numeric value for a given field.
    def field_to_numeric(field)
      idx = FIELDS.index(field.to_s.downcase) || -1
      (2**idx).to_i
    end

    # Calculates an unique numeric value for a collection of fields.
    def numeric_fields(*args)
      result = args.flatten.inject(0) do |memo, value|
        memo + field_to_numeric(value)
      end
      result.zero? ? nil : result
    end
  end
end
