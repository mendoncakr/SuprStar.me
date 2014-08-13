module PartyHelper

  def find_video_helper(party_id)
    @party = Party.find_by_id(party_id)
    @queue = @party.queue
    @current_video = @queue.shift
    @party.update(queue: @queue)
  end
  
end
