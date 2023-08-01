require "spec_helper"

RSpec.describe ServiceFusionApi do
  it 'has a version number' do
    expect(ServiceFusionApi::Version.to_s).not_to be nil
  end

  it 'should init params' do
    client = ServiceFusionApi::Client.new(client_id: 'client_id', client_secret: 'client_secret')
    expect(client.client_id).to eq('client_id')
    expect(client.client_secret).to eq('client_secret')
  end
end
