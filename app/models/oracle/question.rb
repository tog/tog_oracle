class Oracle::Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, :class_name => "Oracle::Answer"
  has_one :suitable_answer, :class_name => "Oracle::Answer", :conditions => { :suitable => true }

  validates_presence_of :body

  named_scope :opened, :conditions => { :opened => true }

  def suitable_answer_id
    sa = self.suitable_answer
    sa.nil? ? nil : sa.id
  end

  def suitable_answer_id=(answer_id)
    answer = ::Oracle::Answer.find(answer_id)
    self.suitable_answer = answer
  end
  
  def suitable_answer=(answer)
    return if suitable_answer == answer
    answers.each do |a|
      a.make_unsuitable!
      a.save
    end
    answer.make_suitable!
    answer.save
  end
  
  def opened?
    !!self.opened
  end
  
  def closed?
    !self.opened?
  end
  
  def close!
    self.opened = false
  end
  
  def closeable?
    self.created_at > 1.hour.ago && self.created_at < 7.days.ago
  end
end