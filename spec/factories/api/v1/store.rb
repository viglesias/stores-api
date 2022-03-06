FactoryBot.define do
  factory "Api::V1::Store" do
    name { Faker::Name.first_name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
  end
end