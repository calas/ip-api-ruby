module IpApi
  # Methods for converting response fields to a numeric value (to save
  # bandwidth). 
  # 
  # Read more: https://ip-api.com/docs/api:json#fieldsTable
  module Fields
    FIELDS = %W[
      country countryCode region regionName city zip lat lon timezone isp org
      as reverse query status message mobile proxy :empty: district continent
      continentCode asname currency hosting offset
    ]

    # Gets the numeric value for a given field. 
    def field_to_numeric(field)
      idx = FIELDS.index(field.to_s.downcase)
      idx.nil? ? 0 : 2**idx
    end

    # Calculates an unique numeric value for a collection of fields.
    def numeric_fields(*args)
      fields = args.flatten

      return nil if fields.empty?

      fields.inject(0) {|memo, value| memo + field_to_numeric(value) }
    end
  end
end
