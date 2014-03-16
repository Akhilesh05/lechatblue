class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :pizza_id
      t.string :name
      t.integer :phone
      t.string :address
      t.string :city
      t.string :pizza_size

      t.timestamps
    end
  end
end
