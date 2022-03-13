require 'rails_helper'

RSpec.describe Api::V1::Product, type: :model do
  let(:product) { FactoryBot.create 'Api::V1::Product' }

  it 'is valid with valid attributes' do
    expect(product).to be_valid
  end

  it 'is not valid without attributes' do
    expect(Api::V1::Product.new).to_not be_valid
  end

  it 'is not valid without name' do
    product.name = nil
    expect(product).to_not be_valid
  end

  it 'is not valid without sku' do
    product.sku = nil
    expect(product).to_not be_valid
  end

  it 'is not valid without sku' do
    product.price = nil
    expect(product).to_not be_valid
  end

  it 'is not valid without price numeric' do
    product.price = "sdsdsd"
    expect(product).to_not be_valid
  end

  it 'is not valid without type' do
    product.product_type = ""
    expect(product).to_not be_valid
  end

end
