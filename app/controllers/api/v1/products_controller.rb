class Api::V1::ProductsController < ApplicationController
  before_action :set_api_v1_product, only: [:show, :update, :destroy]

  # GET /api/v1/products
  def index
    @products = Api::V1::Product.all

    render json: @products
  end

  # GET /api/v1/products/1
  def show
    render json: @product
  end

  # POST /api/v1/products
  def create
    @product = Api::V1::Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_product
      @product = Api::V1::Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :sku, :product_type, :price)
    end
end
