class Api::V1::ProfilesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def create
    @profile = current_user.build_profile(create_profile_params)
    if @profile.save
      # update and confirm email of user
      current_user.email = create_email_params[:email]
      current_user.save
      current_user.confirm!
      render status: 201
    else
      render status: 422
    end
  end

private

  def create_profile_params
    params.require(:profile).permit(:name, :status, :date_of_birth, :gender, profile_image_attributes: [:media])
  end

  def create_email_params
    params.require(:user).permit(:email)
  end
end