# app/models/api/v1/product.rb

# Product
module Api
    module V1
      class Product < ApplicationRecord

        #validates :product_type, inclusion: {in: ["Pizza", "Complement"]}
        validates :name, :sku, :product_type, :price, presence: true
        validates :price, numericality: true

        has_many :product_stores
        has_many :stores, :through => :product_stores

      end
    end
end
