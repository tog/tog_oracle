class Oracle::Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, :class_name => "Oracle::Answer"
  has_one :suitable_answer, :class_name => "Oracle::Answer", :conditions => { :suitable => true }

  validates_presence_of :body, :title
  after_save :close_if_has_suitable_answer
  named_scope :opened, :conditions => { :opened => true }
  named_scope :closed, :conditions => { :opened => false }

  acts_as_taggable

  class << self
    def close_overdues_and_send_notifications
      close_overdues
      send_close_requests_for_overdues
    end
    def close_overdues
      overdues.each { |q| q.close! }
    end
    def send_close_requests_for_overdues
      overdues.each { |q| Oracle::QuestionMailer.deliver_close_question_request(q) }
    end

    def overdues
      self.all.select(&:overdue?)
    end
  end

  def after_initial_answer_period?
    self.created_at + 1.hour < Time.now
  end

  def closeable?
    after_initial_answer_period? && opened?
  end

  def overdue?
    self.created_at + 7.days < Time.now
  end

  def opened?
    !!self.opened
  end

  def closed?
    !self.opened?
  end

  def close!
    self.opened = false
    save!
  end

  private
  def close_if_has_suitable_answer
    return if self.new_record?
    if self.closeable? && !suitable_answer.nil?
      self.close!
    end
  end
end