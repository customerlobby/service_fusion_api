require 'spec_helper'

RSpec.describe ServiceFusionApi::Client::Jobs do

  # Test Case for filter jobs.
  it 'should get jobs' do
    client = ServiceFusionApi::Client.new
    params = { 'end_date[:gte]': '2019-01-20' }
    expect(client).to receive(:get).with('jobs', params)
    client.jobs(params)
  end

  # Test Case to get individual job.
  it 'should get an individual job' do
    client = ServiceFusionApi::Client.new
    expect(client).to receive(:get).with('jobs/id', {})
    client.job('id')
  end

  # Test jobs data from service fusion data.
  # Test case record the http response in
  # get_service_fusion_jobs.yml file for offline mode.
  # This test case call http api.
  it 'should get jobs data with vcr' do
    VCR.use_cassette('get_service_fusion_jobs') do
      @client = ServiceFusionApi.client(access_token: 'access_token')
      jobs = @client.jobs
      expect(jobs.class).to eq(Hash)
      expect(jobs['items'].class).to eq(Hashie::Mash)
      expect(jobs['items']).not_to eq(nil)
    end
  end

  # Test job data from service fusion data.
  # Test case record the http response in
  # get_service_fusion_job_individual.yml file for offline mode.
  # This test case call http api.
  it 'should get individual job with vcr' do
    VCR.use_cassette('get_service_fusion_job_individual') do
      @client = ServiceFusionApi.client(access_token: 'access_token')
      job = @client.job(467_303)
      expect(job['items'].id).to eq(467_303)
    end
  end
end
