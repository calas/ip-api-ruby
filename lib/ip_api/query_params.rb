# frozen_string_literal: true

require 'ip_api/fields'

module IpApi
  # HTTP query params builder for the HTTP Client
  class QueryParams
    include Fields

    attr_reader :lang, :fields

    def initialize(lang: nil, fields: [])
      @lang = lang
      @fields = fields
    end

    def build
      { lang: lang, fields: numeric_fields(fields) }.compact
    end

    def self.build(options)
      new(options).build
    end
  end
end
