class Comment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :party
	#before_create :analyze_sentiment

	def analyze_sentiment
		results = AlchemyAPI.search(:sentiment_analysis, :text => self.content)
		self.score = results["score"].to_i
		self.save
	end
end