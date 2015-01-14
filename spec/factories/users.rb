FactoryGirl.define do
  factory :user do
    sequence :phone_no do |n|
      "123456789#{n}"
    end
    country_code "12345678"
  end

end