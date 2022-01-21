class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.boolean :credit, :default => false
      t.decimal :total
      t.datetime :date
      t.belongs_to :credit
      t.timestamps
    end
  end
end
