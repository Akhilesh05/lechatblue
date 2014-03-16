class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def redirect_to_https
		redirect_to "https://" + request.host + request.fullpath unless (request.ssl? || request.local?)
		#redirect_to protocol: "https://" unless (request.ssl? || request.local?)
	end

	def redirect_to_lechatbluetk
		redirect_to "http://www.lechatbleu.tk" + request.fullpath unless request.host == "www.lechatbleu.tk" || request.host == "lechatbleu.tk" || request.local?
	end

	def redirect_to_herokuapp
		redirect_to "http://lechatbleu.herokuapp.com" + request.fullpath unless request.host == "lechatbleu.herokuapp.com" || request.local?
	end

	def redirect_to_herokuapp_with_ssl
		redirect_to "https://lechatbleu.herokuapp.com" + request.fullpath unless request.host == "lechatbleu.herokuapp.com" || request.local?
	end
end
