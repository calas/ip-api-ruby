require 'httparty'

module IpApi
  class Client
    include HTTParty
    include Fields

    base_uri 'http://ip-api.com'

    def fetch(address, options = {})
      return batch(address, options) if address.is_a?(Array)

      query = build_query(**options) 
      self.class.get("/json/#{address}", query: query)
    end

    def batch(addresses, options = {})
      query = build_query(**options) 
      self.class.post("/batch", { body: addresses.to_json, query: query })
    end

    private

    def build_query(lang: nil, fields: [])
      query = {}
      query[:lang] = lang 
      query[:fields] = numeric_fields(fields) 
      query.compact
    end
  end
end
