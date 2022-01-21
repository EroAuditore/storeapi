class CreateCredits < ActiveRecord::Migration[6.1]
  def change
    create_table :credits do |t|
     
      t.boolean :paid
      t.belongs_to :client
      
      t.timestamps
    end
  end
end
