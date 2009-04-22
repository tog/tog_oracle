class Oracle::Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, :class_name => "Oracle::Answer"
  has_one :suitable_answer, :class_name => "Oracle::Answer", :conditions => { :suitable => true }

  validates_presence_of :body
  before_save :close_if_has_suitable_answer
  named_scope :opened, :conditions => { :opened => true }
  named_scope :overdues, :conditions => { :overdue? => true }
  
  class << self
    def send_close_request_for_overdues
      overdues.each { |q| Oracle::QuestionMailer.deliver_close_question_request(q) }
    end
  end
  
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
  
  def after_initial_answer_period?
    self.created_at > 1.hour.ago
  end
  
  def closeable?
    after_initial_answer_period?
  end
  
  def overdue?
    self.created_at > 7.days.ago
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
    
  private
  def close_if_has_suitable_answer
    self.close! unless suitable_answer.nil? || self.closed?
  end
end