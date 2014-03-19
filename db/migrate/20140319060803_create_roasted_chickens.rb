class CreateRoastedChickens < ActiveRecord::Migration
  def change
    create_table :roasted_chickens do |t|
      t.string :name
      t.text :ingredients
      t.text :description
      t.float :price
      t.boolean :available
      t.string :image

      t.timestamps
    end
  end
end
