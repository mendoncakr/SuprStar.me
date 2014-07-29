class User < ActiveRecord::Base

  belongs_to   :party
  has_many     :songs
  has_many 		 :comments

  validates    :name, presence: true
  validates    :phone_number, presence: true
  validates    :phone_number, format: { :with => /\A\+1\d{10}\z/, :allow_nil => true, message: "Number must consisits of +1 followed by a 10 digit number, i.e. +15551234567" }
end
