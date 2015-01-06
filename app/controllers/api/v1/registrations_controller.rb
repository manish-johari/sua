class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def create
    @resource = User.new(create_params(params))
    if @resource.save
      @auth_token = @resource.create_user_authentication_token(:token => Devise.friendly_token).token
      render status: 201
    else
      warden.custom_failure!
      render status: 422
    end
  end

  def create_params(params)
    params.require(:user).permit(:phone_no, :country_code)
  end

end
