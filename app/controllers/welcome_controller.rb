class WelcomeController < ApplicationController
	def index
		@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [params[:action]],
				scripts: [params[:action]]
		}
	end
end
