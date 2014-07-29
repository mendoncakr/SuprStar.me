require 'rails_helper'

RSpec.describe CommentController, :type => :controller do

  describe "GET #retrieve_comments" do
    it "should returns http success" do
      get :retrieve_comments
      expect(response).to be_success
    end
  end
end
