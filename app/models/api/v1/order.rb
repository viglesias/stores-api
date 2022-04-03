# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  total      :integer
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Api
    module V1
        class Order < ApplicationRecord
            belongs_to :store
            has_many :order_products, class_name: 'Api::V1::OrderProduct'
            has_many :products, through: :order_products

            after_save :calculate_total

            def calculate_total
                total = products.sum(:price)
                update_column(:total, total)
            end
        end
    end
end
