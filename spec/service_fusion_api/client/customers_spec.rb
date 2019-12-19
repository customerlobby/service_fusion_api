require 'spec_helper'

RSpec.describe ServiceFusionApi::Client::Customers do

  # Test Case for filter customers.
  it 'should get customers' do
    client = ServiceFusionApi::Client.new
    params = { 'last_serviced_date[:gte]': '2019-01-20' }
    expect(client).to receive(:get).with('customers', params)
    client.customers(params)
  end

  # Test Case to get individual client.
  it 'should get an individual client' do
    client = ServiceFusionApi::Client.new
    expect(client).to receive(:get).with('customers/id', {})
    client.customer('id')
  end

  # Test customers data from service fusion data.
  # Test case record the http response in
  # get_service_fusion_customers.yml file for offline mode.
  # This test case call http api.
  it 'should get customers data with vcr' do
    VCR.use_cassette('get_service_fusion_customers') do
      @client = ServiceFusionApi.client(access_token: 'access_token')
      customers = @client.customers
      expect(customers.class).to eq(Hash)
      expect(customers['items'].class).to eq(Hashie::Mash)

      expect(customers['items']).not_to eq(nil)
    end
  end

  # Test client data from service fusion data.
  # Test case record the http response in
  # get_service_fusion_customers_individual.yml file for offline mode.
  # This test case call http api.
  it 'should get individual customer data with vcr' do
    VCR.use_cassette('get_service_fusion_customers_individual') do
      @client = ServiceFusionApi.client(access_token: 'access_token')
      customer_record = @client.customer(731219)
      expect(customer_record['items'].id).to eq(731219)
    end
  end

  # Test customers data with filter from service fusion data.
  # Test case record the http response in
  # get_service_m8_customers_filter.yml file for offline mode.
  # This test case call http api.
  it 'should get customers data with filter' do
    VCR.use_cassette('get_service_fusion_customers_filter') do
      @client = ServiceFusionApi.client(access_token: 'access_token')
      customers = @client.customers('last_serviced_date[:gte]': '2017-04-06')
      expect(customers['items']).not_to eq(nil)
    end
  end
end
