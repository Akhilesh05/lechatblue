class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :image

      t.timestamps
    end
  end
end
