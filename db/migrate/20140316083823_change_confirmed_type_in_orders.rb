class ChangeConfirmedTypeInOrders < ActiveRecord::Migration
  def change
	  add_column :orders, :convert_confirmed, :boolean, :default => true

	  # look up the schema's to be able to re-inspect the Project model
	  # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
	  Order.reset_column_information

	  # loop over the collection
	  Order.all.each do |p|
		  p.convert_confirmed = p.confirmed == '1'
		  p.save
	  end

	  # remove the older status column
	  remove_column :orders, :confirmed
	  # rename the convert_status to status column
	  rename_column :orders,:convert_confirmed,:confirmed
  end
end
