# frozen_string_literal: true

module ServiceFusionApi
  class Error < StandardError; end
  class ConnectionError < Error; end
  class AuthorizationError < Error; end
  class BadRequestError < Error; end
  class RecordNotFoundError < Error; end

  class RateLimitError < Error
    attr_reader :rate_limit_reset_at, :status_code

    def initialize(http_response)
      super(http_response.body.message)

      @status_code = http_response.body.code
      @rate_limit_reset_at = Time.current.utc +
                             http_response.headers['X-Rate-Limit-Reset'].to_i
    end
  end
end
