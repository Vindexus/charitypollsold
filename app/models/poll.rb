class Poll < ActiveRecord::Base
  attr_accessor :param_options, :charity_id, :text_options
  belongs_to :charity
  has_many :options
  has_many :votes
  validate :has_options
  validates_presence_of :question

  def has_voted(user_or_uid)
    if user_or_uid.blank?
      return false
    end

    user_id = user_or_uid.respond_to?(:id) ? user_or_uid.id : user_or_uid

    return Vote.verified.where({user_id: user_id, poll_id: self.id}).count > 0    
  end

  def results
    rows = ActiveRecord::Base.connection.exec_query("SELECT COUNT(v.id) as votes, o.name, o.id
      FROM options o
      LEFT JOIN votes v
      ON v.option_id = o.id
      AND v.verified = 't'
      GROUP BY v.option_id
      ORDER BY votes DESC")
    results = []
    total_votes = self.total_votes

    rows.each do |r|
      results.push({votes: r['votes'], name: r['name'], option_id: r['id'], percentage: 100*(r['votes'].to_f / total_votes.to_f)})
    end

    return results
  end

  def total_votes
    self.votes.verified.count
  end

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
