# == Schema Information
#
# Table name: order_products
#
#  id         :bigint           not null, primary key
#  product_id :bigint
#  order_id   :bigint
#
# app/models/api/v1/order_product.rb

# OrderProduct
module Api
  module V1
    class OrderProduct < ApplicationRecord
      belongs_to :order
      belongs_to :product
    end
  end
end
