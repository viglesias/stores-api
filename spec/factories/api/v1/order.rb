FactoryBot.define do
  factory 'Api::V1::Order' do
    store {Api::V1::Store.first || association("Api::V1::Store")}
    trait :with_products do
      transient do
        products { create_list('Api::V1::Product', 5) }
      end

      after(:build) do |order, evaluator|
        order.products << evaluator.products
      end

      after(:create) { |order, _evaluator| order.reload }
    end
  end
end
