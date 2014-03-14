class CreatePizzas < ActiveRecord::Migration
  def change
    create_table :pizzas do |t|
      t.string :name
      t.text :ingredients
      t.text :description
      t.float :price
      t.boolean :available
      t.integer :image

      t.timestamps
    end
  end
end
