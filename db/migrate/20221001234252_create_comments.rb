class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :park_id
      t.integer :child_age
      t.integer :child_moon_age

      t.timestamps
    end
  end
end
