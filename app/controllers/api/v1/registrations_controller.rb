class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def create
    logger.info("User request for signup : #{params}")
    # Find user by phone_no and country_code
    @resource = User.find_by(create_params)
    @verification_token = get_verification_token
    new_token = Devise.token_generator.digest(User, :confirmation_token, @verification_token)
    unless @resource
      @resource = User.new(create_params)
      if @resource.save
        set_confirmation_token new_token
        # send verification code via sms
        render status: 201
      else
        warden.custom_failure!
        render status: 422
      end
    else
      set_confirmation_token new_token
      # send verification code via sms
      render status: 201
    end
  end

  def create_params
    params.require(:user).permit(:phone_no, :country_code)
  end

  def get_verification_token
    SecureRandom.hex(3)
  end

  def set_confirmation_token new_token
    @resource.confirmation_token = new_token
    @resource.save
  end

end
