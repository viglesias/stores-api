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
# app/models/store.rb

# Store
module Api
  module V1
    class Store < ApplicationRecord
      validates :name, :email, :phone, :address, presence: true
      validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

      has_many :product_stores, class_name: "Api::V1::ProductStore"
      has_many :products, :through => :product_stores

    end
  end
end
