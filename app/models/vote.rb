class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  belongs_to :option
  validates_presence_of :option_id
  validates_presence_of :poll_id
  validates_presence_of :user_id
  validate :already_voted

  def already_voted
    if true
      unless self.user_id.blank?
        if Vote.where({user_id: self.user_id, poll_id: self.poll_id}).count > 0
          self.errors.add(:base, "You have already voted on this poll")
        end
      end
    end
  end
end
