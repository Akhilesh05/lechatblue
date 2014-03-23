class RoastedChicken < ActiveRecord::Base
	serialize :ingredients, Array
end
