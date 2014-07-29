require 'rails_helper'

RSpec.describe NotificationController, :type => :controller do

  describe "GET index" do
    xit "should returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET receive_sms" do
    it "should returns http success" do
      get :receive_sms
      expect(response).to be_success
    end
  end

end
