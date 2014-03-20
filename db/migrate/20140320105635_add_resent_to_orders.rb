class AddResentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :resent, :boolean
  end
end
