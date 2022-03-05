class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_params
      params.fetch(:store, {})
    end
end
