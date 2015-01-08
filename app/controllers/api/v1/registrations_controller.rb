class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def create
    logger.info("User request for signup : #{params}")
    # Find user by phone_no and country_code
    @resource = User.find_by(create_params)
    unless @resource
      @resource = User.new(create_params)
      if @resource.save
        # send verification code via sms
        render status: 201
      else
        warden.custom_failure!
        render status: 422
      end
    else
      # send verification code via sms
      render status: 201
    end
  end

  def create_params
    params.require(:user).permit(:phone_no, :country_code)
  end

end
