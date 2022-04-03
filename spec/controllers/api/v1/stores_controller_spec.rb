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

RSpec.describe Api::V1::StoresController do
  it 'sends a list of stores' do
    create_list('Api::V1::Store', 3)

    get :index

    expect(response).to be_successful

    stores = JSON.parse(response.body, symbolize_names: true)

    expect(stores.count).to eq(3)

    stores.each do |store|
      expect(store).to have_key(:id)
      expect(store[:id]).to be_an(Integer)

      expect(store).to have_key(:name)
      expect(store[:name]).to be_a(String)

      expect(store).to have_key(:address)
      expect(store[:address]).to be_a(String)

      expect(store).to have_key(:email)
      expect(store[:email]).to be_a(String)

      expect(store).to have_key(:phone)
      expect(store[:phone]).to be_a(String)
    end
  end

  it 'can get one store by its id' do
    id = create('Api::V1::Store').id

    get :show, params: { id: id }

    store = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(store).to have_key(:id)
    expect(store[:id]).to be_an(Integer)

    expect(store).to have_key(:name)
    expect(store[:name]).to be_a(String)

    expect(store).to have_key(:address)
    expect(store[:address]).to be_a(String)

    expect(store).to have_key(:email)
    expect(store[:email]).to be_a(String)

    expect(store).to have_key(:phone)
    expect(store[:phone]).to be_a(String)
  end

  it 'can create a new store' do
    store_params = {
      name: Faker::Name.first_name,
      address: Faker::Address.full_address,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.cell_phone_with_country_code

    }

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post :create, params: { store: store_params }
    created_store = Api::V1::Store.last

    expect(response).to be_successful
    expect(created_store.name).to eq(store_params[:name])
    expect(created_store.email).to eq(store_params[:email])
    expect(created_store.address).to eq(store_params[:address])
    expect(created_store.phone).to eq(store_params[:phone])
  end

  it 'can update an existing store' do
    id = create('Api::V1::Store').id
    previous_name = Api::V1::Store.last.name
    new_store_name = Faker::Name.first_name
    store_params = { name: new_store_name }

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch :update, params: { id: id, store: store_params }
    store = Api::V1::Store.where(id: id).first

    expect(response).to be_successful
    expect(store.name).to_not eq(previous_name)
    expect(store.name).to eq(new_store_name)
  end

  it 'can destroy a store' do
    store = create('Api::V1::Store')

    expect(Api::V1::Store.count).to eq(1)

    delete :destroy, params: { id: store.id }

    expect(response).to be_successful
    expect(Api::V1::Store.count).to eq(0)
    expect { Api::V1::Store.find(store.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'Store with products' do
    store = create('Api::V1::Store', :with_products)
    get :products, params: {id: store.id}
    expect(response).to be_successful

  end
end
