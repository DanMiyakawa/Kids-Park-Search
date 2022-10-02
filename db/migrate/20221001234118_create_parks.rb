class CreateParks < ActiveRecord::Migration[6.1]
  def change
    create_table :parks do |t|
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.string :post_code
      t.string :address
      t.string :phone
      t.string :business_hours
      t.string :target_age

      t.timestamps
    end
  end
end
