class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def redirect_to_lechatbluetk
		redirect_to "http://www.lechatbleu.tk" + request.fullpath unless request.host == "www.lechatbleu.tk" || request.host == "lechatbleu.tk"
	end
end
