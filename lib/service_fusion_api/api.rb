require File.expand_path('../http_utils/request', __FILE__)
require File.expand_path('../http_utils/response', __FILE__)
require File.expand_path('../http_utils/connection', __FILE__)
require File.expand_path('../configuration', __FILE__)

module ServiceFusionApi
  class API
    include HttpUtils::Request
    include HttpUtils::Response
    include HttpUtils::Connection

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = ServiceFusionApi.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end
  end
end
