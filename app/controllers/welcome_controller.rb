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
		if params[:category] == "pizzas"
			@pizzas = Pizza.all
		end
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
				session[:pizza_ids] = nil
				session[:order_id] = @new_order.id
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
		end
	end

	def confirm_order
		if params[:resend]
			@redirect_to = confirm_order_path
			if get_client_last_order[:success]
				@order = Order.find get_client_last_order[:order_id]
				@resent = @order.resend_confirmation_code
				if @resent[:success]
					flash[:alert] = "Your confirmation code has been sent again"
				elsif @resent[:error_code] == 1
					flash[:alert] = "Please wait at least 10 minutes before requesting a resend :)"
				elsif @resent[:error_code] == 2
					flash[:alert] = "<b>Order expired</b><br />Your order is no longer valid after 2 hours :(<br />Please make another order"
					@redirect_to = place_order_path
				elsif @resent[:error_code] == 3
					flash[:alert] = "Confirmation code has already been resent"
				elsif @resent[:error_code] == 4
					flash[:alert] = "Your latest order has already been confirmed ;)"
					@redirect_to = root_path
				end
			else
				flash[:alert] = "No order found :(<br />We are sincerely sorry for this"
			end
			redirect_to @redirect_to
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
			@redirect_to = confirm_order_path
			if !@order.nil?
				if @order.confirmed
					flash[:alert] = "Order is already confirmed."
				elsif @order.expired
					flash[:alert] = "<b>Order expired</b><br />Your order is no longer valid after 2 hours :(<br />Please make another order"
					@redirect_to = place_order_path
				else
					@order.confirmed = true
					if @order.save
						@redirect_to = root_path
						@order.alert_admin
						flash[:alert] = "Your order has been confirmed"
					else
						flash[:alert] = "Unknown error occurred :("
					end
				end
			else
				flash[:alert] = "Order not found. Cross check your confirmation code."
			end
			redirect_to @redirect_to
		elsif request.get?
			@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				other_styles: [],
				scripts: [params[:action]],
				other_scripts: [],
				title: "Le Chat Bleu - Confirm order"
			}
		end
	end

	private
		def get_order_params
			params.require(:order).permit :name, :address, :phone, :city
		end

		def get_client_last_order
			if session[:order_id].nil?
				@order = Order.where(client_ip: request.remote_ip.to_s).last
				record_identified = @order.nil? ? false : true
				{:success => record_identified, :order_id => record_identified ? @order.id : nil}
			else
				@order = Order.find(session[:order_id])
				record_identified = @order.nil? ? false : true
				{:success => record_identified, :order_id => record_identified ? @order.id : nil}
			end
		end
end
