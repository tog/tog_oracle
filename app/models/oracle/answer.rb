class Oracle::Answer < ActiveRecord::Base

  belongs_to :question, :class_name => "Oracle::Question"
  belongs_to :user

  validates_presence_of :body

  acts_as_rateable :average => true

  def make_suitable!
    self.suitable = true
  end

  def make_unsuitable!
    self.suitable = false
  end

  def suitable?
    !!self.suitable
  end
end