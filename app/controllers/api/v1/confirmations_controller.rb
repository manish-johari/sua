class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def show
    # Encrypt the token recieved by user.
    token = Devise.token_generator.digest(User, :confirmation_token, show_params[:confirmation_token])
    # Match the token
    @status =  current_user.confirmation_token.eql? token
    unless @status
      render status: 422
    else
      render status: 200
    end
  end

private
  def show_params
    params.require(:user).permit(:confirmation_token)
  end

end
