# app/models/api/v1/product.rb

# Product
module Api
    module V1
      class Product < ApplicationRecord

        validates :type, inclusion: {in: ["Pizza", "Complement"]}

        has_many :product_stores
        has_many :stores, :through => :product_stores

        def self.type
            %w(Pizza Complement)
        end
      end
    end
end
