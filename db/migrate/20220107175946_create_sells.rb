class CreateSells < ActiveRecord::Migration[6.1]
  def change
    create_table :sells do |t|
      t.boolean :credit, :default => false
      t.decimal :total
      t.datetime :date

      t.timestamps
    end
  end
end
