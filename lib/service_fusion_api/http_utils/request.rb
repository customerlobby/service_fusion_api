# frozen_string_literal: true

module ServiceFusionApi
  class HttpUtils
    # Defines HTTP request methods
    module Request
      RATE_LIMIT_STATUS_CODE = 429
      GATEWAY_TIME_OUT_CODE = 504

      # Perform an HTTP GET request
      def get(path, options = {})
        request(:get, path, options)
      end

      # Perform an HTTP POST request
      def post(path, options = {})
        request(:post, path, options)
      end

      private

      def request(method, path, options)
        http_response = connection.send(method) do |request|
          case method
          when :get
            formatted_options = format_options(options)
            request.url(path, formatted_options)
          when :post, :put
            request.headers['Content-Type'] = 'application/json'
            request.body = options.to_json unless options.empty?
            request.url(path)
          end
          request.options.timeout = 120 # read timeout
          request.options.open_timeout = 300 # connection timeout
        end

        # Raise an error based on the response status code
        case http_response.status
        when 401, 403
          raise ServiceFusionApi::AuthorizationError, http_response
        when RATE_LIMIT_STATUS_CODE
          raise ServiceFusionApi::RateLimitError, http_response
        when GATEWAY_TIME_OUT_CODE
          raise ServiceFusionApi::GatewayTimeoutError, http_response.body
        end

        data = Response.create(http_response.body)
        response = {}
        response['items'] = data
        response
      end

      # Format the Options before you send them off to ServiceM8
      def format_options(options)
        return if options.blank?

        opts = {}
        opts[options[:filter][:key]] = options[:filter][:value] if options.key?(:filter)
        opts['expand'] = options[:expand] if options.key?(:expand)
        opts['page'] = options[:page] if options.key?(:page)
        opts['per-page'] = options[:"per-page"] if options.key?(:"per-page")
        opts
      end
    end
  end
end
