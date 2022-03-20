FactoryBot.define do
  factory 'Api::V1::Product' do
    name  { Faker::Restaurant.name }
    sku   { Faker::Restaurant.name }
    product_type { %w[Pizza Complement][rand(0..1)] }
    price { Faker::Commerce.price.to_f }
  end
end
