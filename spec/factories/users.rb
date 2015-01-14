FactoryGirl.define do
  factory :user do
    sequence :phone_num do |n|
      "123456789#{n}"
    end
    country_code "+91"
  end

end