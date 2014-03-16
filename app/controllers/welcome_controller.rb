class WelcomeController < ApplicationController
	before_action :redirect_to_lechatbluetk
	def index
		@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
		        other_scripts: [],
		        title: "Le Chat Blue"
		}
	end
	def menu_book
		@layout_details = {
			controller: params[:controller],
			action: params[:action],
			styles: [params[:action]],
			other_styles: [],
			scripts: [params[:action]],
			other_scripts: [],
			title: "Le Chat Blue - Menu"
		}
	end
	def menu_category
		@layout_details = {
			controller: params[:controller],
			action: params[:action],
			styles: [params[:action]],
			other_styles: [],
			scripts: [params[:action]],
			other_scripts: [],
			title: "Le Chat Blue - Pizzas"
		}
		@pizzas = Pizza.all
	end
	def place_order
		if request.post?
			@new_order = Order.new get_order_params
			@new_order.save
			Order.find(@new_order.id).send_confirmation_code
			render text: get_order_params.to_s
		else
			@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
				other_scripts: [],
				title: "Le Chat Blue - Order Now"
			}
		end
	end

	private
		def get_order_params
			params.require(:order).permit(:name, :address, :phone, :city, :pizza_id, :pizza_size)
		end
end
