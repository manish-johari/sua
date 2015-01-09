class Api::V1::ProfilesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def create
    @profile = current_user.build_profile(create_params)
    if @profile.save
      render status: 201
    else
      render status: 422
    end
  end

private

  def create_params
    params.require(:profile).permit(:name, :status, :date_of_birth, :gender, profile_images_attributes: [:media])
  end
end