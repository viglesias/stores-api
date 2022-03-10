# app/models/store.rb

# Store
module Api
  module V1
    class Store < ApplicationRecord
      validates :name, :email, :phone, :address, presence: true
      validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

      has_many :product_stores
      has_many :products, :through => :product_stores
    end
  end
end
