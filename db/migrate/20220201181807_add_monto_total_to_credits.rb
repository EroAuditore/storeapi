class AddMontoTotalToCredits < ActiveRecord::Migration[6.1]
  def change
    add_column :credits, :total, :decimal, precision: 10, scale: 2
  end
end
