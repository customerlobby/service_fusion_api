# frozen_string_literal: true

require 'faraday_middleware'
Dir[File.expand_path('../faraday/*.rb', __FILE__)].each { |f| require f }

module ServiceFusionApi
  class HttpUtils
    # connection module
    module Connection
      private

      def connection
        options = {
          url: "https://#{endpoint}#{api_version}/"
        }

        Faraday::Connection.new(options) do |connection|
          if access_token
            connection.use ServiceFusionApi::FaradayMiddleware::Auth, access_token
          else
            connection.use Faraday::Request::BasicAuthentication, client_id, client_secret
          end
          connection.use ServiceFusionApi::FaradayMiddleware::RaiseException
          connection.use ::FaradayMiddleware::Mashify
          connection.use ::Faraday::Response::ParseJson
          connection.adapter(adapter)
        end
      end
    end
  end
end
