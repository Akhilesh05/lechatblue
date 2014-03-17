class AddClientIpFromOrders < ActiveRecord::Migration
  def change
    add_column :orders, :client_ip, :string
  end
end
