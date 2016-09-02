$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'yandex_locator'
require "codeclimate-test-reporter"
require 'vcr'
CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.before(:all) do
    YandexLocator.configure do |config|
      config.api_key = "APZfyVcBAAAA58Y4RgIAjmWLTkHXPpAtP4z6Y97H8hyag8cAAAAAAAAAAADWjG3srAFgoWZtF-IvDCgxB_DT6Q=="#ENV['YANDEX_API_KEY']
      config.version = "1.0"
    end

    VCR.configure do |c|
      c.default_cassette_options = { :serialize_with => :syck }
      c.hook_into :faraday, :webmock
      c.cassette_library_dir = 'spec/cassettes'
    end

  end
end

