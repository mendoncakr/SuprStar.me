class NotificationController < ApplicationController
	include NotificationHelper

	def index

	end

	def receive_sms
		text = read_received_sms
		phone_number = text.from
		arr = text.body.split(",")
		welcome = text.body
		hash_tag = arr[0].strip
		name = arr[1]
		title_artist = arr[2]


		user = User.find_by(phone_number: phone_number)
		party = Party.where(hash_tag: hash_tag)

		get_ready_to_sing = 'Get ready to sing SuprStar!
												To sing again text 1 and then your song.
												To send a comment text 2 and then your comment.'
		check_format_for_hashtag = "Please try to verify party, name, artist and song again"
		did_not_recognize = "Try again SuprStar. example #SuprStar, Matt Bunday, Friday by Rebecca Black"
		second_song = "Going again SuprStar?"
		be_nice = "...."


		if hash_tag.include?('#') && name && title_artist
				# Save user's name, number, party_id
				# Save song's name, user_id, party_id
				video = find(song_info)
				user = User.create(name: name, phone_number: phone_number, party_id: party.first.id)
				Song.create(name: video.title, user_id: user.id, party_id: user.party.id, youtube_url: video.ytid)
				send_sms(phone_number, get_ready_to_sing) #confirmed

		elsif !hash_tag.include?('#') && name && title_artist
			send_sms(phone_number, check_format_for_hashtag) #confirmed

		elsif user && !arr.include?(",") && hash_tag.include?('2') #comments
			send_sms(phone_number, be_nice) #confirmed
				# Save comment's content, user_id, party_id
				Comment.create(content: hash_tag, user_id: user.id, party_id: user.party.id)

		elsif party && hash_tag.include?("1") #anything but blank
			send_sms(phone_number, second_song) #confirmed

		elsif
			send_sms(phone_number, did_not_recognize)

		end
	end

	def authenticate

	end

end
