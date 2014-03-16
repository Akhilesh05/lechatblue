class Order < ActiveRecord::Base
	require 'clockwork'
	after_create :generate_confirmation_code

	def send_confirmation_code
		#api = Clockwork::API.new( 'ed6b6375448b8925b9f2739c10c103e71d78f231' )
		#message = api.messages.build :to => "230#{self.phone}", :content => "Your confirmation code is: #{self.confirmation_code}\nPlease confirm your order on http://lechatbleu.tk/confirm-order."
		#response = message.deliver
	end

	private
		def generate_confirmation_code
			digest = Digest::MD5.hexdigest "+lcb#{self.id}lcb-"
			conf_code = "#{self.id}-#{digest[0..2]}-#{digest[10..12]}"
			self.update_attributes confirmation_code: conf_code
		end
end
