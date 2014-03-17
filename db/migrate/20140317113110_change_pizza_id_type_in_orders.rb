class ChangePizzaIdTypeInOrders < ActiveRecord::Migration
  def change
	  change_column :orders, :pizza_id, :string
  end
end
