class ChangePriceTypeInPizzas < ActiveRecord::Migration
  def change
	  change_column :pizzas, :price, :string
  end
end
