# frozen_string_literal: true

require 'ip_api/version'
require 'ip_api/client'

# Main IpApi module
module IpApi
  # Base error class for IpApi
  class Error < StandardError; end

  def self.info(*args)
    @client ||= Client.new
    @client.fetch(*args)
  end
end
