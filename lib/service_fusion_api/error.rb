module ServiceFusionApi
  class Error < StandardError; end
  class ConnectionError < Error; end
  class AuthorizationError < Error; end
  class BadRequestError < Error; end
  class RecordNotFoundError < Error; end
  class RateLimitError < Error; end
end
