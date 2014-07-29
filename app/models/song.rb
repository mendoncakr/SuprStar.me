class Song < ActiveRecord::Base
  include ActiveModel::Serialization

  belongs_to  :user
  belongs_to  :party

  validates    :name, presence: true
  validates    :youtube_url, presence: true
end
