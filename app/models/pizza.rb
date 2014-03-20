class Pizza < ActiveRecord::Base
	serialize :ingredients, Array
	serialize :add_ons, Array
	serialize :price, Hash

	def get_price
		self.price
	end
end
