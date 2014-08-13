module ApplicationHelper

  def current_party
    @current_party ||= Party.find(session[:party_id]) if session[:party_id]
  end

  def verification?(text)
  	return true if text[0].include?("#")
  end

  def new_song(text)
		return true if text[0].include?("1")
  end

  def new_comment(text)
  	return true if text[0].include?("2")
  end

  def find_party(hashtag)
  	Party.find_by_hash_tag(hashtag)
  end

  def parse_text(text)
  	text.slice!(1..text.length)
  end

  def add_song_to_user_queue(user, song)
    party_queue = user.party.queue
    party_queue << song.serializable_hash
  end

  #WIP: How to pass new queue to update?
  
  # def update_party_queue(party)
  #   party.update(queue: party_queue)
  # end

end
