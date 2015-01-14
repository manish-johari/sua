require 'rails_helper'

RSpec.describe User, :type => :model do

  let (:user) { FactoryGirl.create(:user) }

  it "should be valid" do
    expect(user.valid?).to be_truthy
  end

  it "should not be valid" do
    expect(FactoryGirl.build(:user, phone_num: "").valid?).to be_falsey
  end

end