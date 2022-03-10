require'swagger_helper'

describe'API V1 Product', swagger_doc:'v1/swagger.yaml' do
  path'/api/v1/products' do
    get'Retrieves Products' do
    description'Retrieves all the products'
      produces'application/json'
      let(:collection_count) { 5 }
      let(:expected_collection_count) { collection_count * 2 }
      before { 
                create_list("Api::V1::Pizza", collection_count)
                create_list("Api::V1::Complement", collection_count)
             }
      response'200','Products retrieved' do
      schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              sku: { type: :string },
              type: { type: :string },
              price: { type: :string }
            }
          }
        run_test! do |response|
          expect(JSON.parse(response.body).count).to eq(expected_collection_count)
        end
      end
    end
    post'Creates Product' do
        description'Creates Product'
        consumes'application/json'
        produces'application/json'
        parameter(name: :product, in: :body)
        response'201','stote created' do
          let(:product) do
            {
              name: 'Some title',
              sku: 'Some body',
              type: 'Pizza',
              price: "23.5"
            }
          end
          run_test!
        end
      end
  end
end