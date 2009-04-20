class Oracle::Answer < ActiveRecord::Base
  
  belongs_to :question, :class_name => "Oracle::Question"
  belongs_to :user

  validates_presence_of :body
end