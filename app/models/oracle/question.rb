class Oracle::Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, :class_name => "Oracle::Answer"

end