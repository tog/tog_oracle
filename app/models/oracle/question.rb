class Oracle::Question < ActiveRecord::Base

  belongs_to :publisher, :class_name => :user
  has_many :answers, :class_name => "Oracle::Answer"

end