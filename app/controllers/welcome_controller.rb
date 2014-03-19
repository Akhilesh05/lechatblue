class WelcomeController < ApplicationController
	before_action :redirect_to_lechatbleutk, except: [:create_order]
	before_action :redirect_to_herokuapp_with_ssl, only: [:create_order]

	def index
		@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
		        other_scripts: [],
		        title: "Le Chat Bleu"
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
			title: "Le Chat Bleu - Menu"
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
			title: "Le Chat Bleu - Pizzas"
		}
		@pizzas = Pizza.all
	end
	def place_order
		@layout_details = {
			controller: params[:controller],
			action: params[:action],
			styles: [params[:action]],
			other_styles: [],
			scripts: [params[:action]],
			other_scripts: [],
			title: "Le Chat Bleu - Order Now"
		}
		@pizzas = Pizza.all
	end

	def create_order
		if request.post?
			@new_order = Order.new get_order_params
			@new_order.client_ip = request.remote_ip
			@new_order.pizza_id = params.require(:order)[:pizza_id].values.to_a
			@new_order.pizza_size = params.require(:order)[:pizza_size].values.to_a
			if @new_order.save
				Order.find(@new_order.id).send_confirmation_code
				redirect_to confirm_order_path
			else
				flash[:error] = @new_order.errors.full_messages.join "<br />"
				redirect_to create_order_path
			end
		elsif !params[:pizza_id].nil?
			if session[:pizza_ids].nil?
				session[:pizza_ids] = [params[:pizza_id]]
			else
				#if ! session[:pizza_ids].include? params[:pizza_id]
					session[:pizza_ids] << params[:pizza_id]
				#end
			end
			redirect_to create_order_path
		elsif params[:cancel]
			session[:pizza_ids] = nil
			redirect_to place_order_path
		elsif params[:remove_pizza]
			session[:pizza_ids].delete_at(session[:pizza_ids].index params[:id] )
			render nothing: true
		elsif request.get?
			@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
				other_scripts: [],
				title: "Le Chat Bleu - Order Now"
			}
			#render text: Order.find(37).pizza_id[0]
		end
	end

	def confirm_order
		if request.get?
			@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
				other_scripts: [],
				title: "Le Chat Bleu - Confirm order"
			}
		elsif request.post?
			@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
				other_scripts: [],
				title: "Le Chat Bleu - Confirm order"
			}
			@order = Order.find_by(confirmation_code: params[:confirm_order][:confirmation_code])
			if !@order.nil?
				if @order.confirmed
					@return = "Order is already confirmed."
				else
					@order.confirmed = true
					if @order.save
						@order.alert_admin
						@return = "Your order has been confirmed"
					else
						@return = "Unknown error occurred :("
					end
				end
			else
				@return = "Order not found. Cross check your confirmation code."
			end
		end
	end

	private
		def get_order_params
			params.require(:order).permit :name, :address, :phone, :city
		end
end
