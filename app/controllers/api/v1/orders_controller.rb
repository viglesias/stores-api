# app/controllers/orders_controller.rb

module Api
  module V1
    # == OrdersController
    class OrdersController < ApplicationController
      before_action :set_api_v1_order, only: [:show, :update, :destroy]

      # GET /orders
      def index
        @orders = Order.all

        render json: @orders
      end

      # GET /orders/1
      def show
        render json: @order
      end

      # POST /orders
      def create
        @order = Order.new(order_params)
        if @order.save
          OrderMailer.send_confirmation(@order)
          render json: @order, status: :created
        else
          render json: error_message(@order), status: :unprocessable_entity
        end
      end

      # PATCH/PUT /orders/1
      def update
        if @order.update(order_params)
          render json: @order
        else
          render json: error_message(@order), status: :unprocessable_entity
        end
      end

      # DELETE /orders/1
      def destroy
        @order.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_api_v1_order
        @order = Order.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def order_params
        params.require(:order).permit(:total, :store_id, product_ids: [])
      end
    end
  end
end
