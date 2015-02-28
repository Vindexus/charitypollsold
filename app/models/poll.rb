class Poll < ActiveRecord::Base
  attr_accessor :param_answers, :charity_id, :text_answers
  belongs_to :charity
  has_many :answers
  validate :has_answers
  validates_presence_of :question

  def has_answers
    num_answers = 0
    msg = ""
    self.text_answers = []

    if !param_answers.nil?
      (0..3).each do |i|
        answer_text = param_answers[i.to_s].to_s
        if !answer_text.empty? && num_answers < 5
          num_answers = num_answers + 1
        end
        self.text_answers.push(answer_text)
      end
    end

    if num_answers < 2
      errors.add(:base, "You must provide at least 2 answers")
    end
  end

  def save_text_answers
    self.text_answers.each do |a|
      self.answers.create({answer: a})
    end
    self.text_answers = []
  end
end
