require 'spec_helper'
require 'pry'

describe YandexLocator do
  it 'has a version number' do
    expect(YandexLocator::VERSION).not_to be nil
  end

  context "configiration" do

    it 'check default configuration' do
      expect(YandexLocator.configuration.version).to eq "1.0"
    end

    it 'check set new configuration value' do
      YandexLocator.configure do |config|
        config.api_key = "test_api_key"
        config.version = "2.0"
      end

      expect(YandexLocator.configuration.api_key).to eq("test_api_key")
      expect(YandexLocator.configuration.version).to eq("2.0")
    end
  end

  context "VCR" do

    it "should do" do

      conn = Faraday::Connection.new(:url => "http://api.lbs.yandex.net/geolocation") do |builder|
        builder.use VCR::Middleware::Faraday
        builder.adapter :net_http
      end

      VCR.use_cassette('example') do
        # client = YandexLocator::Client.new
        # result = client.lookup(ip: "109.252.52.39")
        result = conn.post do |req|
          req.headers['Content-Type'] = 'application/json'
          req.params['json'] = {
            common:
              {
                version: YandexLocator.configuration.version,
                api_key: YandexLocator.configuration.api_key
              },
            ip: 
              {
                address_v4: "109.252.52.39"
              }            
          }.to_json
        end
      end
    end
  end

end
