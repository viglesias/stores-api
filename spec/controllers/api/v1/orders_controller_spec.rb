require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Api::V1::OrdersController do
  it 'sends a list of orders' do
    create('Api::V1::Order', :with_products)
    create('Api::V1::Order', :with_products)
    create('Api::V1::Order', :with_products)

    get :index

    expect(response).to be_successful

    orders = Api::V1::Order.all

    expect(orders.count).to eq(3)

    orders.each do |order|
      expect(order.store_id).to be_an(Integer)
      expect(order.products.length).to eq 5
    end
  end

  it 'can get one order by its id' do
    id = create('Api::V1::Order', :with_products).id

    get :show, params: { id: id }

    order = Api::V1::Order.last

    expect(response).to be_successful

    expect(order.id).to be_an(Integer)

    expect(order.store_id).to be_a(Integer)
  end

  it 'can create a new order' do
    order_params = {
      store_id: create('Api::V1::Store').id,
      product_ids: create_list('Api::V1::Product', 3).map(&:id)

    }

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post :create, params: { order: order_params }
    created_order = Api::V1::Order.last

    expect(response).to be_successful
    expect(created_order.store_id).to eq(order_params[:store_id])
    expect(created_order.product_ids).to eq(order_params[:product_ids])
  end

  it 'can update an existing order' do
    id = create('Api::V1::Order', :with_products).id
    product_ids = Api::V1::Order.last.product_ids
    new_product_id = create('Api::V1::Product').id
    new_product_ids = [product_ids, new_product_id].flatten
    order_params = { product_ids: new_product_ids }

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch :update, params: { id: id, order: order_params }
    order = Api::V1::Order.where(id: id).first

    expect(response).to be_successful
    expect(order.product_ids).to_not eq(product_ids)
    expect(order.product_ids).to eq(new_product_ids)
  end

  it 'can destroy a order' do
    order = create('Api::V1::Order')

    expect(Api::V1::Order.count).to eq(1)

    delete :destroy, params: { id: order.id }

    expect(response).to be_successful
    expect(Api::V1::Order.count).to eq(0)
    expect { Api::V1::Order.find(order.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end