class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :description
      t.string :code
      t.decimal :sale_price, precision: 10, scale: 2
      t.decimal :purchase_price, precision: 10, scale: 2
      t.decimal :bulk_price, precision: 10, scale: 2
      t.boolean :bulk
      
      t.timestamps
    end
  end
end
