class WelcomeController < ApplicationController
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
end
