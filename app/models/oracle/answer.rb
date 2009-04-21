class Oracle::Answer < ActiveRecord::Base
  
  belongs_to :question, :class_name => "Oracle::Question"
  belongs_to :user

  validates_presence_of :body
  
  def make_suitable!
    self.suitable = true
  end

  def suitable?
    self.suitable
  end
end