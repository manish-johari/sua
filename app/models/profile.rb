class Profile < ActiveRecord::Base
  validates :gender, presence: true, inclusion: {in: ['m', 'f', 'M', 'F'], message: "should be either Male or Female."}

  has_one :profile_image, as: :attachable, :class_name => "Profile::Image", :dependent => :destroy
  accepts_nested_attributes_for :profile_image
end
