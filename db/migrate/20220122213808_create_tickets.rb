class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.decimal :price
      t.string :description
      t.belongs_to :sale
      t.belongs_to :product

      t.timestamps
    end
  end
end
