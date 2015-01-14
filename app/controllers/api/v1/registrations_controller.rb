class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def create
    logger.info("User request for signup : #{params}")
    # Find user by phone_num and country_code
    @resource = User.find_by(create_params)
    @verification_token = get_verification_token
    new_token = Devise.token_generator.digest(User, :confirmation_token, @verification_token)
    unless @resource
      @resource = User.new(create_params)
      if @resource.save
        @resource.confirm!
        set_confirmation_token new_token
        # send verification code via sms
        send_sms "#{create_params[:country_code] + create_params[:phone_num]}", @verification_token
        @auth_token = @resource.create_user_authentication_token(:token => Devise.friendly_token).token
        render status: 201
      else
        warden.custom_failure!
        render status: 422
      end
    else
      set_confirmation_token new_token
      # send verification code via sms
      send_sms "#{create_params[:country_code] + create_params[:phone_num]}", @verification_token
      @auth_token = @resource.create_user_authentication_token(:token => Devise.friendly_token).token
      render status: 201
    end
  end

private

  def create_params
    params[:user][:phone_num].gsub!(/\D/, '')
    params.require(:user).permit(:phone_num, :country_code)
  end

  def get_verification_token
    SecureRandom.hex(3)
  end

  def set_confirmation_token new_token
    @resource.confirmation_token = new_token
    @resource.save
  end

  def send_sms phone_num, token
    puts "sending sms token #{token} to #{phone_num}"

    @twilio_client = Twilio::REST::Client.new APP_CONFIG[:TWILIO_SID], APP_CONFIG[:TWILIO_TOKEN]
    @twilio_client.account.messages.create(
      :from => "+1#{APP_CONFIG[:TWILIO_PHONE_NUMBER]}",
      :to => phone_num,
      :body => "Ahoy from See You All!. Enter Confirmation Token: #{token} to verify your account. This is a 1-time message."
    )
  end

end
