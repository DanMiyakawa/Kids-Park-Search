class CreateParks < ActiveRecord::Migration[6.1]
  def change
    create_table :parks do |t|
      t.integer :genre_id, null: false
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.string :address, null: false
      t.string :phone
      t.time :start_time
      t.time :end_time
      t.integer :child_age
      t.integer :child_moon_age
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
