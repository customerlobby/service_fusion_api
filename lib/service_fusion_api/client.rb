# frozen_string_literal: true

module ServiceFusionApi
  # Wrapper for the FieldEdge REST API.
  class Client < ServiceFusionApi::API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include ServiceFusionApi::Client::Customers
    include ServiceFusionApi::Client::Jobs
  end
end
