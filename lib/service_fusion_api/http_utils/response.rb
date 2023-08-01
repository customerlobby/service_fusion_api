module ServiceFusionApi
  class HttpUtils
    module Response
      def self.create(response_hash)
        data = response_hash['data'].dup rescue response_hash
        data ||= response_hash
        data.extend(self)
        raise ServiceFusionApi::AuthorizationError.new(data.error) if data.respond_to?(:error)
        data
      end
    end
  end
end
