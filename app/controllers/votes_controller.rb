class VotesController < ApplicationController
  before_action :set_poll, only: [:create]

  def create
    @vote_form = VoteForm.new(params[:vote_form])
    extra_errors = []
    
    if user_signed_in?
      @vote_form.user_id = current_user.id
    else
      #extra_errors.push "Not signed in"
      user_params = @vote_form.user_params
      
      # Registering a new user as they are voting
      if @vote_form.user_login_or_register == 'register'
        #extra_errors.push "Trying to registyer"
        user = User.new(user_params)
        if !user.save
          @vote_form.append_errors(user)
          extra_errors += user.errors.to_a
          #@vote_form.errors.add(:base, "User isn't valid on register")
        else
          sign_in user
          @user = user
          @vote_form.user_id = user.id
        end
      # Trying to log in with an existing user
      else
        #extra_errors.push "Trying to login"
        user = User.find_by_email(@vote_form.user_email)

        if user.nil?
          extra_errors.push "Incorrect email or password"
        else
          if user.valid_password?(@vote_form.user_password)
            sign_in user
            @user = user
            @vote_form.user_id = user.id
          else
            extra_errors.push "Incorrect email or password"
          end
        end
      end
    end
    
    @vote = @vote_form.build_vote
    @vote_form.extra_errors = extra_errors


    respond_to do |format|
      if @vote_form.valid? && @vote.save
        format.html { redirect_to @poll, notice: "Your vote was added." }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render "polls/show" }
        format.json { render json: @vote_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_user
      if user_signed_in?
        return @user
      else

      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:option_id)
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :login_or_register)
    end
end
