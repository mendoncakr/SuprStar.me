module NotificationHelper
	def twilio_client
    twilio_token = ENV["TWILIO_API_KEY"]
    twilio_sid = ENV["TWILIO_ACC_SID"]
    client = Twilio::REST::Client.new twilio_sid, twilio_token
	end

	def send_sms(phone_number, body)
		twilio_client.account.messages.create(
			:from => ENV["TWILIO_NUMBER"],
			:to => phone_number,
			:body => body
			)
	end

	def read_sms
		twilio_client.account.messages.list({:to => ENV["TWILIO_NUMBER"]}).first
	end

end
