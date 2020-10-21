# frozen_string_literal: true

require 'httparty'
require 'ip_api/query_params'

module IpApi
  # HTTP client class for the json ReST API
  class Client
    include HTTParty

    base_uri 'http://ip-api.com'

    def fetch(address, options = {})
      return batch(address, options) if address.is_a?(Array)

      query = QueryParams.build(**options)
      self.class.get("/json/#{address}", query: query)
    end

    def batch(addresses, options = {})
      query = QueryParams.build(**options)
      self.class.post('/batch', { body: addresses.to_json, query: query })
    end
  end
end
