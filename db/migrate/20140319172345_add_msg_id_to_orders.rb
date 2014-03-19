class AddMsgIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :msg_id, :string
  end
end
