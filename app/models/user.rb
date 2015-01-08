class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable

  has_one :user_authentication_token, dependent: :destroy

  validates :phone_no, presence: true
  validates :phone_no, uniqueness: { scope: :country_code }
  validates :country_code, presence: true

end
