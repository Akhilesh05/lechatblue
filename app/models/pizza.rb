class Pizza < ActiveRecord::Base
	def get_price
		i = 0
		x = self.price.split(";").map{ |price|
			i+=1
			[ i == 1 ? :small : i == 2 ? :medium : :large , price]
		}
		Hash[x]
	end
end
