class Oracle::Answer < ActiveRecord::Base

  belongs_to :question, :class_name => "Oracle::Question"
  belongs_to :user

  validates_presence_of :body

  acts_as_rateable :average => true
  acts_as_abusable

  def make_suitable!
    self.suitable = true
    self.save!
  end

  def make_unsuitable!
    self.suitable = false
    self.save!
  end

  def suitable?
    !!self.suitable
  end
end