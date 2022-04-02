Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get '/', to: redirect('/api-docs')

  namespace :api do
    namespace :v1 do
      resources :stores do
        member do
          get 'products'
          match 'add_product/:product_id' => 'stores#add_product', via: :post
        end
      end
      resources :products
    end
  end
end
