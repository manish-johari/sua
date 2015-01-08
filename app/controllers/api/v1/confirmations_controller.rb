class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :verify_authenticity_token

  def show
    @user = User.confirm_by_token show_params[:confirmation_token]
    if @user.errors.present?
      render status: 422
    else
      @auth_token = @user.create_user_authentication_token(:token => Devise.friendly_token).token
      render status: 200
    end
  end

private
  def show_params
    params.require(:user).permit(:confirmation_token)
  end

end
