require 'swagger_helper'

describe 'API V1 Store', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/stores' do
    get 'Retrieves Stores' do
      description 'Retrieves all the stores'
      produces 'application/json'
      let(:collection_count) { 5 }
      let(:expected_collection_count) { collection_count }
      before { create_list('Api::V1::Store', collection_count) }
      response '200', 'Stores retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   address: { type: :string },
                   email: { type: :string },
                   phone: { type: :string }
                 }
               }
        run_test! do |response|
          expect(JSON.parse(response.body).count).to eq(expected_collection_count)
        end
      end
    end

    post 'Creates Store' do
      description 'Creates Store'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :store, in: :body, schema: {
                  type: :object,
                  properties: {
                    store: {
                      type: :object,
                      properties: {
                        name: { type: :string },
                        address: { type: :string },
                        email: { type: :string },
                        phone: { type: :string }
                      },
                      required: %w[name address email phone]
                    }
                  }
                })
      response '201', 'store created' do
        let(:store) do
          {
            name: 'Some title',
            address: 'Some body',
            email: 'email@email.com',
            phone: '111111111'
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/stores/{id}' do
    parameter name: :id, in: :path, type: :integer
    let(:existent_api_v1_store) { create('Api::V1::Store') }
    let(:id) { existent_api_v1_store.id }
    get 'Show Store' do
      produces 'application/json'
      response '200', 'store retrieved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 address: { type: :string },
                 email: { type: :string },
                 phone: { type: :string }
               }
        run_test!
      end
      response '404', 'invalid store id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    put 'Updates Store' do
      description 'Updates Store'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :store, in: :body, schema: {
                  type: :object,
                  properties: {
                    store: {
                      type: :object,
                      properties: {
                        name: { type: :string },
                        address: { type: :string },
                        email: { type: :string },
                        phone: { type: :string }
                      },
                      required: %w[name address email phone]
                    }
                  }
                })
      response '200', 'store updated' do
        let(:store) do
          {
            name: 'Some title',
            address: 'Some body',
            email: 'email@email.com',
            phone: '111111111'
          }
        end
        run_test!
      end
    end
    delete 'Deletes Store' do
      produces 'application/json'
      description 'Deletes specific store'
      response '204', 'store deleted' do
        run_test!
      end
      response '404', 'store not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
  path '/api/v1/stores/{id}/products' do
    parameter name: :id, in: :path, type: :integer
    get 'Show Store products' do
      let(:existent_api_v1_store_with_products) { create('Api::V1::Store', :with_products) }
      let(:id) { existent_api_v1_store_with_products.id }
      let(:expected_collection_count) { 5 }
      produces 'application/json'
      before { create_list('Api::V1::Product', expected_collection_count) }
      response '200', 'Products retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   sku: { type: :string },
                   product_type: { type: :string },
                   price: { type: :float }
                 }
               }
        run_test! do |response|
          expect(JSON.parse(response.body).count).to eq(expected_collection_count)
        end
      end
      response '404', 'invalid store id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/stores/{id}/add_product/{product_id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :product_id, in: :path, type: :integer
    let(:existent_api_v1_store_with_products) { create('Api::V1::Store', :with_products) }
    let(:existent_api_v1_product) { create('Api::V1::Product') }
    let(:id) { existent_api_v1_store_with_products.id }
    let(:product_id) { existent_api_v1_product.id }
    let(:product_stores) do
      FactoryBot.build(:product_stores,
                       product_id: existent_api_v1_product.id,
                       store_id: existent_api_v1_store_with_products.id)
    end
    let(:expected_collection_count) { 5 }
    post 'Add product to store' do
      produces 'application/json'
      response '200', 'Products retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   sku: { type: :string },
                   product_type: { type: :string },
                   price: { type: :float }
                 }
               }
        run_test! do |response|
          expect(JSON.parse(response.body).count).to eq(expected_collection_count + 1)
        end
      end
      response '404', 'invalid store id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
