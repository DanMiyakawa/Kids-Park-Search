class CreateParks < ActiveRecord::Migration[6.1]
  def change
    create_table :parks do |t|
      t.integer :genre_id
      t.integer :customer_id
      t.string :name
      t.text :introduction
      t.string :address
      t.string :phone
      t.time :start_time
      t.time :end_time
      t.integer :child_age
      t.integer :child_moon_age

      t.timestamps
    end
  end
end
