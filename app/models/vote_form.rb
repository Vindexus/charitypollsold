class VoteForm
  include ActiveModel::Model

  attr_accessor :poll_id, :option_id, :user_email, :user_login_or_register, :user_password, :user_password_confirmation, :user_id, :extra_errors

  #validate :my_validate

  validate :before_val

  def before_val
    extra_errors.each do |msg|
      self.errors.add(:base, msg)
    end

    vote = build_vote
    if !vote.valid?
      append_errors(vote)
    end
  end

  def my_validate
    self.errors.add(:base, "CHeese")
  end

  def user_login_or_register
  	@user_login_or_register ||= 'register'
  end

  def user_params
    {email: self.user_email, password: self.user_password, password_confirmation: self.user_password_confirmation}
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