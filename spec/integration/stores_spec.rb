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
      parameter(name: :store, in: :body)
      response '201', 'stote created' do
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
    get 'Retrieves Store' do
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
      parameter(name: :store, in: :body)
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
end
