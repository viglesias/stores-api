# app/controllers/stores_controller.rb

module Api
  module V1
    # Controller for stores
    class StoresController < ApplicationController
      before_action :set_store, only: [:show, :update, :destroy, :products, :add_product]

      # GET /api/v1/stores
      def index
        @stores = Store.all

        render json: @stores
      end

      # GET /api/v1/stores/1
      def show
        render json: @store
      end

      # POST /api/v1/stores
      def create
        @store = Api::V1::Store.new(store_params)

        if @store.save
          render json: @store, status: :created, location: @store
        else
          render json: @store.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/stores/1
      def update
        if @store.update(store_params)
          render json: @store
        else
          render json: @store.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/stores/1
      def destroy
        @store.destroy
      end

      # Get /api/v1/stores/1/add_product/2
      def add_product
        product = Product.find(params[:product_id])
        if(product && @store)
          @store.products << product
          @store.save ? (render json: @store.products) : (render json: @store.errors, status: :unprocessable_entity)
        else
          render json: {error: "Product or Store incorrect"}.to_json , status: :unprocessable_entity
        end
      end

      # Get /api/v1/stores/1/products
      def products
        render json: @store.products
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_store
        @store = Store.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def store_params
        params.require(:store).permit(:name, :address, :email, :phone, :product_id)
      end
    end
  end
end
