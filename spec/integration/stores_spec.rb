describe 'Users API' do

  path '/api/v1/stores' do

    post 'Creates a store' do
      tags 'Stores'
      consumes 'application/json'
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          address: { type: :string },
          email: { type: :string },
          phone: { type: :string }
        },
        required: [ 'name', 'address', "email", "phone" ]
      }

      response '201', 'user created' do
        let(:store) { { name: 'Store 1', address: 'address 1', email: "email@email.com", phone: "123456789" } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:store) { { name: 'Store 1' } }
        run_test!
      end
    end
  end

  path '/api/v1/stores/{id}' do

    delete 'Delete a store' do
      tags 'Stores'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string
      
      response '200', 'User deleted' do
        let(:id) {create("Api::V1::Store").id}

        run_test!
      end
    end
  end

  path '/api/v1/stores' do

    get 'Retrieves all stores' do
      tags 'Stores'
      produces 'application/json'
      
      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            address: { type: :string },
            email: { type: :string },
            phone: { type: :string }
          },
          required: [ 'id', 'name', 'address', "email", "phone" ]

        let(:id) { create("Api::V1::Store").id }
        run_test!
      end
    end
  end

  path '/api/v1/stores/{id}' do

    get 'Retrieves a store' do
      tags 'Stores'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'Store found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            address: { type: :string },
            email: { type: :string },
            phone: { type: :string }
          },
          required: [ 'id', 'name', 'address', "email", "phone" ]

        let(:id) { create("Api::V1::Store").id }
        run_test!
      end

      response '404', 'Store not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end