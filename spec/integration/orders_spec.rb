require 'swagger_helper'

describe 'API V1 Order', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/Orders' do
    get 'Retrieves Orders' do
      description 'Retrieves all the Orders'
      produces 'application/json'
      let(:expected_collection_count) { 5 }
      before { create_list('Api::V1::Order', expected_collection_count) }
      response '200', 'Orders retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   store_id: { type: :integer },
                   product_ids: {
                    type: 'object',
                    properties: {
                      type: 'array',
                      items: { type: :integer }
                     }
                    },
                   total: { type: :float }
                 }
               }
        run_test! do |response|
          expect(JSON.parse(response.body).count).to eq(expected_collection_count)
        end
      end
    end
    post 'Creates Order' do
      description 'Creates Order'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :Order, in: :body)
      response '201', 'stote created' do
        let(:order){create('Api::V1::Order', :with_products)}
        run_test!
      end
    end
  end
  path '/api/v1/Orders/{id}' do
    parameter name: :id, in: :path, type: :integer
    let(:existent_api_v1_order) { create('Api::V1::Order') }
    let(:id) { existent_api_v1_order.id }
    get 'Show Order' do
      produces 'application/json'
      response '200', 'Order retrieved' do
        schema type: :object,
               properties: {
                id: { type: :integer },
                store_id: { type: :integer },
                product_ids: {
                    type: 'object',
                    properties: {
                      type: 'array',
                      items: { type: :integer }
                     }
                    },
                total: { type: :float }
               }
        run_test!
      end
      response '404', 'invalid Order id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    put 'Updates Order' do
      description 'Updates Order'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :Order, in: :body)
      response '200', 'Order updated' do
        let(:order){create('Api::V1::Order', :with_products)}
        run_test!
      end
    end
    delete 'Deletes Order' do
      produces 'application/json'
      description 'Deletes specific Order'
      response '204', 'Order deleted' do
        run_test!
      end
      response '404', 'Order not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
