class CreateProductStores < ActiveRecord::Migration[5.2]
  def change
    create_table :product_stores do |t|
      t.belongs_to :product
      t.belongs_to :store
    end
  end
end
