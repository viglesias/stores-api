require 'swagger_helper'

describe 'API V1 Product', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/products' do
    get 'Retrieves Products' do
      description 'Retrieves all the products'
      produces 'application/json'
      let(:expected_collection_count) { 5 }
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
    end
    post 'Creates Product' do
      description 'Creates Product'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :product, in: :body, schema: {
        type: :object,
               properties: {
                 name: { type: :string },
                 sku: { type: :string },
                 product_type: { type: :string },
                 price: { type: :float }
               }
      })
      response '201', 'stote created' do
        let(:product) do
          {
            name: 'Some title',
            sku: 'Some body',
            product_type: 'Pizza',
            price: '23.5'
          }
        end
        run_test!
      end
    end
  end
  path '/api/v1/products/{id}' do
    parameter name: :id, in: :path, type: :integer
    let(:existent_api_v1_product) { create('Api::V1::Product') }
    let(:id) { existent_api_v1_product.id }
    get 'Show Product' do
      produces 'application/json'
      response '200', 'product retrieved' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 sku: { type: :string },
                 product_type: { type: :string },
                 price: { type: :float }
               }
        run_test!
      end
      response '404', 'invalid product id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    put 'Updates product' do
      description 'Updates product'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :product, in: :body, schema: {
        type: :object,
               properties: {
                 name: { type: :string },
                 sku: { type: :string },
                 product_type: { type: :string },
                 price: { type: :float }
               }
      })
      response '200', 'product updated' do
        let(:product) do
          {
            name: 'Pizza asturiana',
            sku: 'Pizza asturiana',
            product_type: 'Pizza',
            price: 14.95
          }
        end
        run_test!
      end
    end
    delete 'Deletes product' do
      produces 'application/json'
      description 'Deletes specific product'
      response '204', 'product deleted' do
        run_test!
      end
      response '404', 'product not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
