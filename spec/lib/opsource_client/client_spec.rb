require 'spec_helper'

describe OpsourceClient::Client do

  it "should be configurable" do
     client = OpsourceClient::Client.new
     client.api_endpoint.should == "https://api.opsourcecloud.net/oec/0.9/"

     client.api_endpoint = "http://google.com/"
     client.api_endpoint.should == "http://google.com/"

     client.admin_username = "hi"
     client.admin_username.should == "hi"
  end

end