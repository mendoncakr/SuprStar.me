class CommentController < ApplicationController
	skip_before_action :verify_authenticity_token
	respond_to :json

	def retrieve_comments
		  @party = Party.find_by_id(session[:party_id]) #where to get party id from?
		  @comments = @party.comments.where("created_at > ?", Time.at(params[:time].to_i + 1))
		  @new_comments = []
		  @comments.each do |com|
			hash = {name: com.user.name, obj: com}
			@new_comments << hash
		end

		render json: {content: @new_comments}.to_json
	end

end
