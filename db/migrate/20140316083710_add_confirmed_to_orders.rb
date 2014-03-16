class AddConfirmedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmed, :string
  end
end
