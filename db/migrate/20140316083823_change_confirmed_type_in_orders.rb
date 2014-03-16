class ChangeConfirmedTypeInOrders < ActiveRecord::Migration
  def change
	  change_column :orders, :confirmed, :boolean
  end
end
