# app/models/api/v1/product.rb

# Product
module Api
    module V1
      class ProductStore < ApplicationRecord
        belongs_to :store
        belongs_to :product
      end
    end
end
