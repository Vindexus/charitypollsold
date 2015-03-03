class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  belongs_to :option
  validates_presence_of :option_id, :poll_id, :user_id
  validate :validate_user, on: :create

  scope :verified, -> {where(verified: true)}

  before_create :before_create

  def before_create
    self.verified = true
  end

  def validate_user
    unless self.user_id.blank?
      if self.poll.has_voted(self.user_id)
        self.errors.add(:base, "You have already voted on this poll")
      end
    end
  end
end
