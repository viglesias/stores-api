# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# spec/models/store_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::Store, type: :model do
  let(:store) { FactoryBot.create 'Api::V1::Store' }

  it 'is valid with valid attributes' do
    expect(store).to be_valid
  end

  it 'is not valid without attributes' do
    expect(Api::V1::Store.new).to_not be_valid
  end

  it 'is not valid without a name' do
    store.name = nil
    expect(store).to_not be_valid
  end

  it 'is not valid without an address' do
    store.address = nil
    expect(store).to_not be_valid
  end
  it 'is not valid without an email' do
    store.email = nil
    expect(store).to_not be_valid
  end
  it 'is not valid without a phone' do
    store.phone = nil
    expect(store).to_not be_valid
  end
  it 'is not valid with an email with incorrect format' do
    store.email = 'email.com'
    expect(store).to_not be_valid
  end
end
