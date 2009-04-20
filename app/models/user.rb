class User < ActiveRecord::Base
  has_many :questions, :class_name => "Oracle::Question"
end