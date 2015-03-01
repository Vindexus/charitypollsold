class Poll < ActiveRecord::Base
  attr_accessor :param_options, :charity_id, :text_options
  belongs_to :charity
  has_many :options
  has_many :votes
  validate :has_options
  validates_presence_of :question

  def has_options
    num_options = 0
    msg = ""
    self.text_options = []

    if !param_options.nil?
      (0..3).each do |i|
        option_text = param_options[i.to_s].to_s
        if !option_text.empty? && num_options < 5
          num_options = num_options + 1
        end
        self.text_options.push(option_text)
      end
    end

    if num_options < 2
      errors.add(:base, "You must provide at least 2 options")
    end
  end

  def save_text_options
    self.text_options.each do |a|
      self.options.create({name: a})
    end
    self.text_options = []
  end
end
