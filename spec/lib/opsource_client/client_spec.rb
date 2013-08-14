require 'spec_helper'

describe OpsourceClient::Client do

  it "should be configurable" do
     client = OpsourceClient::Client.new

     client.admin_username = "hi"

     client.admin_username.should == "hi"
  end

end