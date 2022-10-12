class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :customer_id
      t.string :title
      t.text :body
      t.text :memo
      t.integer :status, null: false, default: 0
      
      t.timestamps
    end
  end
end
