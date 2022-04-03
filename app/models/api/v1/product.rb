# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  name         :string
#  sku          :string
#  product_type :string
#  price        :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# app/models/api/v1/product.rb

# Product
module Api
  module V1
    class Product < ApplicationRecord
      validates :product_type, inclusion: { in: %w[Pizza Complement] }
      validates :name, :sku, :product_type, :price, presence: true
      validates :price, numericality: true

      has_many :product_stores
      has_many :stores, through: :product_stores
    end
  end
end
