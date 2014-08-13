class Party < ActiveRecord::Base
  serialize :queue

  has_many     :users, dependent: :destroy
  has_many     :songs, dependent: :destroy
  has_many 		 :comments, dependent: :destroy

  validates    :hash_tag, presence: true
  # validates    :hash_tag, uniqueness: true

end
