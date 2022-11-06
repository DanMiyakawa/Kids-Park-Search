class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :customer_id
      t.integer :title, null: false, default: 0
      t.text :body, null: false
      t.text :memo
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
