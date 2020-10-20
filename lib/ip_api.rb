require "ip_api/version"
require "ip_api/fields"
require "ip_api/client"

module IpApi
  class Error < StandardError; end

  def self.info(*args)
    @client ||= Client.new
    @client.fetch(*args)
  end
end
