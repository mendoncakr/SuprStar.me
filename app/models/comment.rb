class Comment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :party
  before_create :value

  def analyze_sentiment
     results = AlchemyAPI.search(:sentiment_analysis, :text => self.content)
  end

  def value
    self.score = self.analyze_sentiment["score"].to_f
  end
end
