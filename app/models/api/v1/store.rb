# app/models/store.rb

# Store
module Api
  module V1
    class Store < ApplicationRecord
        validates :name, :email, :phone, :address, presence: true
        validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    end
  end
end