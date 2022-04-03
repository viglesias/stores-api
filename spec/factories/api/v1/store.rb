FactoryBot.define do
  factory 'Api::V1::Store' do
    name { Faker::Name.first_name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    trait :with_products do
      transient do
        products { create_list('Api::V1::Product', 5) }
      end

      after(:build) do |store, evaluator|
        store.products << evaluator.products
      end

      after(:create) { |store, _evaluator| store.reload }
    end
  end
end
