require 'rails_helper'

RSpec.describe User, :type => :model do

	context "associations" do
		it { should belong_to(:party) }
		it { should have_many(:songs) }
		it { should have_many(:comments) }
	end

	context "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:phone_number) }
		it { should_not allow_value("+1234567890").for(:phone_number) }
	end
end
