class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #:validatable

  has_one :user_authentication_token, dependent: :destroy

  validates :phone_no, presence: true, uniqueness: true
  validates :country_code, presence: true
end
