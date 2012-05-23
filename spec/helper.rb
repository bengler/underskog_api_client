# encoding: utf-8
unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'underskog'
require 'rspec'
require 'webmock/rspec'

def a_delete(path, endpoint=Underskog.endpoint)
  a_request(:delete, endpoint + path)
end

def a_get(path, endpoint=Underskog.endpoint)
  a_request(:get, endpoint + path)
end

def a_post(path, endpoint=Underskog.endpoint)
  a_request(:post, endpoint + path)
end

def a_put(path, endpoint=Underskog.endpoint)
  a_request(:put, endpoint + path)
end

def stub_delete(path, endpoint=Underskog.endpoint)
  stub_request(:delete, endpoint + path)
end

def stub_get(path, endpoint=Underskog.endpoint)
  stub_request(:get, endpoint + path)
end

def stub_post(path, endpoint=Underskog.endpoint)
  stub_request(:post, endpoint + path)
end

def stub_put(path, endpoint=Underskog.endpoint)
  stub_request(:put, endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
