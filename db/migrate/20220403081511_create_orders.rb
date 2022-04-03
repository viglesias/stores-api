class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total
      t.references :store

      t.timestamps
    end
  end
end
