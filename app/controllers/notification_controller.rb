class NotificationController < ApplicationController
	include NotificationHelper
	include YouTubeHelper
	include TextMessageHelper

	skip_before_action :verify_authenticity_token

	def index

	end

	def receive_sms
		read_sms
	end
	
end
