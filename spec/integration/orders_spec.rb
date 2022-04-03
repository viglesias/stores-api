require 'swagger_helper'

describe 'API V1 order', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/orders' do
    get 'Retrieves orders' do
      description 'Retrieves all the orders'
      produces 'application/json'
      let(:expected_collection_count) { 5 }
      before { create_list('Api::V1::Order', expected_collection_count) }
      response '200', 'orders retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   product_ids: {
                    type: 'array',
                    items: { type: :integer }
                   },
                   store_id: { type: :integer },                  
                   total: { type: :integer }
                 }
               }
        run_test! do |response|
          expect(JSON.parse(response.body).count).to eq(expected_collection_count)
        end
      end
    end
    post 'Creates order' do
      description 'Creates order'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :order, in: :body, schema: {
          type: :object,
            properties: {
            store_id: { type: :integer },
            product_ids: {
                type: 'array',
                items: { type: :integer }
               },
          }
        })
      response '201', 'order created' do
        let(:existent_api_v1_store_with_products) { create('Api::V1::Store', :with_products) }
        let(:order) do { 
            store_id: existent_api_v1_store_with_products.id,
            total: 100, 
            product_ids: [1,2,3,4,5]
         }
        end
        run_test!
      end
    end
  end
  path '/api/v1/orders/{id}' do
    parameter name: :id, in: :path, type: :integer
    let(:existent_api_v1_order) { create('Api::V1::Order') }
    let(:id) { existent_api_v1_order.id }
    get 'Show order' do
      produces 'application/json'
      response '200', 'order retrieved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 store_id: { type: :integer },
                 product_ids: {
                    type: 'array',
                    items: { type: :integer }
                   },
                 total: { type: :float }
               }
        run_test!
      end
      response '404', 'invalid order id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    put 'Updates order' do
      description 'Updates order'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :order, in: :body, schema: {
        type: :object,
          properties: {
          store_id: { type: :integer },
          product_ids: {
              type: 'array',
              items: { type: :integer }
             }
        }
      })
      response '200', 'order updated' do
        let(:existent_api_v1_store_with_products) { create('Api::V1::Store', :with_products) }
        let(:order) do { 
            store_id: existent_api_v1_store_with_products.id,
            total: 100, 
            product_ids: [1,2,3,4,5]
         }
        end
        run_test!
      end
    end
    delete 'Deletes order' do
      produces 'application/json'
      description 'Deletes specific order'
      response '204', 'order deleted' do
        run_test!
      end
      response '404', 'order not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
