require 'spec_helper'
describe ApplePushNotification do

  # Not really sure how to test all of this since we cant actually send a notification
  # Just testing variables and failures for now

  context "Setup" do
    
    it "should have basic setup" do
      ApplePushNotification::APN_PORT.should == 2195
      ApplePushNotification.class_variable_defined?(:@@apn_cert).should be_true
      ApplePushNotification.class_variable_defined?(:@@apn_host).should be_true
    end
    
  end

  context "Standalone" do
    
    it "should fail" do
      lambda {
        ApplePushNotification.send_notification nil
      }.should raise_error OpenSSL::PKey::RSAError, 'Neither PUB key nor PRIV key:: not enough data'
    end
  
  end
  
  context "When user" do
    
    before :each do
      @user = User.first
    end
    
    it "should fail without cert" do
      lambda {
        @user.send_notification 'test notification'
      }.should raise_error OpenSSL::PKey::RSAError, 'Neither PUB key nor PRIV key:: not enough data'
    end
    
    it "should fail without message" do
      lambda {
        @user.send_notification
      }.should raise_error ArgumentError, 'wrong number of arguments (0 for 1)'
    end
  
  end

end