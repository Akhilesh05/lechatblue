class AjaxController < ApplicationController
	def get_pizza_details
		@pizza = Pizza.find params[:pizza_id]
		if @pizza.nil?
			render json: {:error => "404"}
		else
			render json: @pizza
		end
	end
end
