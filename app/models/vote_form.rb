class VoteForm
  include ActiveModel::Model

  attr_accessor :poll_id, :option_id, :user_email, :user_login_or_register, :user_password, :user_password_confirmation, :user_id

  validates_presence_of :option_id

  validate :validate

  def validate
    vote = build_vote

    if !vote.valid?
      append_errors(vote)
    end
  end

  def user_login_or_register
  	@user_login_or_register ||= 'register'
  end

  def build_user
    if self.user_id.blank?
      user = User.new({email: self.user_email, password: self.user_password, password_confirmation: self.user_password_confirmation})
    else
      user = User.find_by_id(self.user_id)
    end
    return user
  end

  def build_vote
  	vote = Vote.new({poll_id: self.poll_id, option_id: self.option_id, user_id: self.user_id})
  	return vote
  end

  def append_errors(obj)
    unless obj.valid?
      obj.errors.full_messages.each do |msg|
        self.errors.add(:base, msg)
      end
    end
  end
end