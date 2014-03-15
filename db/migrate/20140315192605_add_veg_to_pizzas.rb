class AddVegToPizzas < ActiveRecord::Migration
  def change
    add_column :pizzas, :veg, :boolean
  end
end
