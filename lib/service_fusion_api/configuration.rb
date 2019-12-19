module ServiceFusionApi
  module Configuration
    VALID_OPTIONS_KEYS = [
      :client_id,
      :client_secret,
      :access_token,
      :api_version,
      :adapter,
      :endpoint
    ].freeze

    # By default don't set the access token.
    DEFAULT_ACCESS_TOKEN = nil

    # Use the default Faraday adapter.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default use the main api URL.
    DEFAULT_ENDPOINT = 'api.servicefusion.com'.freeze

    DEFAULT_API_VERSION = '/v1'.freeze

    DEFAULT_CLIENT_ID = nil

    DEFAULT_CLIENT_SECRET = nil

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # When this module is extended, reset all settings.
    def self.extended(base)
      base.reset
    end

    # Reset all configuration settings to default values.
    def reset
      self.client_id = DEFAULT_CLIENT_ID
      self.client_secret = DEFAULT_CLIENT_SECRET
      self.api_version = DEFAULT_API_VERSION
      self.access_token = DEFAULT_ACCESS_TOKEN
      self.endpoint = DEFAULT_ENDPOINT
      self.adapter = DEFAULT_ADAPTER
    end
  end
end
