module FaradayMiddleware
  class ServiceFusionApiOAuth < Faraday::Middleware
    def initialize(app, access_token)
      @app = app
      @access_token = access_token
    end

    def call(env)
      env[:request_headers].merge!('Authorization' => "Bearer #{@access_token}")
      @app.call env
    end
  end
end
