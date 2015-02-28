class Poll < ActiveRecord::Base
  attr_accessor :answer

  validates_presence_of :question
  validate :has_answers

  def has_answers
    num_answers = 0

    if !self.answer.nil?
      self.answer.each do |a|
        if a.empty?
          num_answers = num_answers + 1
        end
      end
    end

    if num_answers < 2
      errors.add(:answers, "You must provide at least 2 answers")
    end
  end
end
