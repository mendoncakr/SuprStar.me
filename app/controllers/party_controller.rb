class PartyController < ApplicationController
  include YouTubeHelper
  respond_to :json
  def index
    @party = Party.new
    @user = User.new
    @song = Song.new
  end

  def show
    @party = Party.find(session[:party_id])
    @comments = @party.comments
    @queue = @queue = @party.queue

  end

  def create
    @party = Party.new(party_params)
    #@party.save!
    @user = User.new(user_params)
    #@user.save!
    @song = Song.new(first_song)
    #@song.save!
    if @party.save && @user.save
      @user.update(phone_number: "+1" + @user.phone_number)
      session[:party_id] = @party.id
      first = find(first_song[:name])
      first[:title]
      @song = Song.create(name: first[:title], youtube_url: first[:ytid], user_id: @user.id, party_id: @party.id)
      @party.queue = []
      @queue = @party.queue << @song.serializable_hash
      @party.update(queue: @queue)
      redirect_to retrieve_party_path
    elsif
      flash[:notice] = @user.errors.messages
      flash[:notice] = @party.errors.messages
      render 'index'
    end
  end

  def retrieve_video_id
    @party = Party.find_by_id(session[:party_id]) #where to find id?
    @queue = @party.queue
    @current_video = @queue.shift
    @party.update(queue: @queue)

    render json: {url: @current_video }
  end

  def retrieve_queue
    @queue = Party.find_by_id(session[:party_id]).queue
    render json: {queue: @queue}
  end

  private
  def party_params
    params.require(:party).permit(:hash_tag)
  end

  def first_song
    params.require(:song).permit(:name)
  end

  def user_params
    params.require(:user).permit(:name, :phone_number)
  end
end
