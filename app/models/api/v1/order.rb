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