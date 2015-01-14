class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable

  has_one :user_authentication_token, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :phone_no, presence: true
  validates :phone_no, uniqueness: { scope: :country_code }
  validates :country_code, presence: true

end
