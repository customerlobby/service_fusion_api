require 'spec_helper'

RSpec.describe ServiceFusionApi::HttpUtils::Connection do
  it 'should use basic authentication' do
    client = ServiceFusionApi::Client.new(client_id: 'client_id', client_secret: 'client_secret')
    conn = double
    expect(Faraday::Connection).to receive(:new).and_yield(conn)
    expect(conn).to receive(:use).with(Faraday::Request::BasicAuthentication, 'client_id', 'client_secret')
    allow(conn).to receive(:adapter)
    allow(conn).to receive(:use)
    client.send(:connection)
  end

  it 'should use oauth2 authentication' do
    client = ServiceFusionApi::Client.new(access_token: 'token')
    conn = double
    expect(Faraday::Connection).to receive(:new).and_yield(conn)
    expect(conn).to receive(:use).with(FaradayMiddleware::ServiceFusionApiOAuth, 'token')
    allow(conn).to receive(:adapter)
    allow(conn).to receive(:use)
    client.send(:connection)
  end
end
