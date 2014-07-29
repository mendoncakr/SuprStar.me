class Party < ActiveRecord::Base
  serialize :queue

  has_many     :users
  has_many     :songs
  has_many 		 :comments

  validates    :hash_tag, presence: true
  # validates    :hash_tag, uniqueness: true

end
