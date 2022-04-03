# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#
require 'rails_helper'

RSpec.describe Api::V1::Order, type: :model do
  let(:store) { FactoryBot.create 'Api::V1::Store' }
  let(:order) { FactoryBot.create 'Api::V1::Order' }

  it 'is valid with valid attributes' do
    expect(order).to be_valid
  end

  it 'is not valid without attributes' do
    expect(Api::V1::Order.new).to_not be_valid
  end

  it 'is not valid without a store' do
    order.store = nil
    expect(order).to_not be_valid
  end

  it 'total price is correct' do
    total = order.products.sum(&:price)
    expect(order.total).eql? total.to_s
  end
end
