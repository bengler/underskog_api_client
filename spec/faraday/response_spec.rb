require 'helper'

describe Faraday::Response do
  before do
    @client = Underskog::Client.new
  end

  {
    400 => Underskog::Error::BadRequest,
    401 => Underskog::Error::Unauthorized,
    403 => Underskog::Error::Forbidden,
    404 => Underskog::Error::NotFound,
    406 => Underskog::Error::NotAcceptable,
    500 => Underskog::Error::InternalServerError,
    502 => Underskog::Error::BadGateway,
    503 => Underskog::Error::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_request(:get, "https://localhost/api/v1/users/1?access_token&id=1").
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.user(1)
        end.should raise_error(exception)
      end
    end
  end

  context "when response status is 404 from lookup" do

    before do
      stub_request(:get, "https://localhost/api/v1/users/0?access_token&id=0").
        to_return(:status => 404)
    end

    it "should raise Underskog::Error::NotFound" do
      lambda do
        @client.user(0)
      end.should raise_error(Underskog::Error::NotFound)
    end

  end
end
