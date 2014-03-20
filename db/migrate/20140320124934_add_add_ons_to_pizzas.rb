class AddAddOnsToPizzas < ActiveRecord::Migration
  def change
    add_column :pizzas, :add_ons, :string
  end
end
