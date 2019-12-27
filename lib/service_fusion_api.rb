require 'faraday'
require 'faraday_middleware'
require 'active_support/all'
require 'service_fusion_api/version'

require File.expand_path('../service_fusion_api/configuration', __FILE__)
require File.expand_path('../service_fusion_api/api', __FILE__)
require File.expand_path('../service_fusion_api/client', __FILE__)
require File.expand_path('../service_fusion_api/error', __FILE__)
require File.expand_path('../faraday/auth', __FILE__)
require File.expand_path('../faraday/raise_exception', __FILE__)

module ServiceFusionApi
  extend Configuration
  # Alias for ServiceFusionApi::Client.new
  # @return [ServiceFusionApi::Client]
  def self.client(options = {})
    ServiceFusionApi::Client.new(options)
  end

  # Delegate to ServiceFusionApi::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end
end
