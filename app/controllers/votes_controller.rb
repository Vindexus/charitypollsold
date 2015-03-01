class VotesController < ApplicationController
  before_action :set_poll, only: [:create]

  def create
    @vote_form = VoteForm.new(params[:vote_form])

    if user_signed_in?
      @vote_form.user_id = current_user.id
    end

    @vote = @vote_form.build_vote

    respond_to do |format|
      if @vote_form.valid? && @vote.save
        format.html { redirect_to @poll, notice: "Your vote was added for #{@vote.user_id}" }
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
