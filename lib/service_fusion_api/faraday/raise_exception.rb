require "nokogiri"

module ServiceFusionApi
  module FaradayMiddleware
    class RaiseException < Faraday::Middleware
      def initialize(app)
        super(app)
      end

      def call(env)
        begin
          @app.call(env)
        rescue Faraday::Error::ConnectionFailed, Faraday::TimeoutError => e
          raise ServiceFusionApi::ConnectionError.new(e)
        rescue Faraday::ParsingError => e
          if e.message.squish.include?("<body>")
            html = Nokogiri::HTML.parse(e.message.split('\'')[1])
            error_message = html.css("p").text
            if error_message.include?("ID is not valid")
              raise ServiceFusionApi::RecordNotFoundError.new(error_message)
            elsif error_message.include?("Gateway Time-out")
              raise ServiceFusionApi::GatewayTimeoutError.new(error_message)
            elsif error_message.include?("It seems you don't have access to this document.")
              raise ServiceFusionApi::AuthorizationError.new("It seems you don't have access to this document.")
            else
              raise ServiceFusionApi::BadRequestError.new(error_message)
            end
          else
            raise ServiceFusionApi::AuthorizationError.new(e)
          end
        end
      end
    end
  end
end
