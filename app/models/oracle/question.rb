class Oracle::Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, :class_name => "Oracle::Answer"
  has_one :suitable_answer, :class_name => "Oracle::Answer", :conditions => { :suitable => true }

  validates_presence_of :body

  def suitable_answer_id
    sa = self.suitable_answer
    sa.nil? ? nil : sa.id
  end

  def suitable_answer_id=(answer_id)
    answer = ::Oracle::Answer.find(answer_id)
    answer.make_suitable!
    self.suitable_answer = answer
  end
end