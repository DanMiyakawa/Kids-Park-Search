class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.integer :customer_id, null: false
      t.integer :park_id, null: false
      t.integer :child_age
      t.integer :child_moon_age
      t.decimal :score, precision: 5, scale: 3

      t.timestamps
    end
  end
end
