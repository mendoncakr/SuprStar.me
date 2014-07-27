class PartyController < ApplicationController

  def index
    
  end
  def new
    @party = Party.new
    @user = User.new
  end

  def create
    @party = Party.new(party_params)
    @user = User.new(user_params)

    if @party.save && @user.save
      redirect_to 'root'
    else
      render 'new'
    end
  end

  private
    def party_params
      params.require(:party).permit(:hash_tag)
    end

    def user_params
      params.require(:user).permit(:name, :phone_number)
    end
end
