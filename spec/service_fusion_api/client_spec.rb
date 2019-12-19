require 'spec_helper'

RSpec.describe ServiceFusionApi::Client do
  it 'should connect using the configured endpoint and api version' do
    client = ServiceFusionApi::Client.new(api_version: '/v1')
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq("https://#{client.endpoint}/v1/")
  end
end
