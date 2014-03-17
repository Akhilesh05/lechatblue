class RemoveClientIpFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :client_ip, :string
  end
end
