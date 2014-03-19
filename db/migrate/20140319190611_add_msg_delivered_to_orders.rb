class AddMsgDeliveredToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :msg_delivered, :boolean
  end
end
