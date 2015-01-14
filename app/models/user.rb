class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable

  has_one :user_authentication_token, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :phone_num, presence: true
  validates :phone_num, numericality: { only_integer: true }
  validates :phone_num, uniqueness: { scope: :country_code }

  validates :country_code, presence: true

  after_save :set_full_no

  def set_full_no
    full_phone_num = country_code.to_s + phone_num.to_s
    self.update_column(:full_phone_num, full_phone_num)
  end

end
