require 'clockwork'

class Order < ActiveRecord::Base
	serialize :pizza_size, Array
	serialize :pizza_id, Array

	after_validation :init
	after_create :generate_confirmation_code

	validates :name, :pizza_size, :pizza_id, :phone, :address, :city, presence: true
	validates :phone, length: {is: 8}

	def send_confirmation_code
		api = Clockwork::API.new 'ed6b6375448b8925b9f2739c10c103e71d78f231'
		message = api.messages.build :to => "230#{self.phone}", :content => "Your confirmation code is: #{self.confirmation_code}\nPlease confirm your order on http://lechatbleu.tk/confirm-order.", :from => "LeChatBleu"
		response = message.deliver
		self.msg_id = "#{response.message_id}"
		self.save
	end

	def alert_admin
		api = Clockwork::API.new 'ed6b6375448b8925b9f2739c10c103e71d78f231'
		order_description = ""
		(0..(self.pizza_id.length-1)).each do |i|
			size = self.pizza_size[i] == "s" ? "Small" : self.pizza_size[i] == "m" ? "Medium" : "Large"
			pizza_name = Pizza.find(self.pizza_id[i].to_i).name
			order_description += "\n#{self.pizza_id[i]} - #{pizza_name} - #{size}"
		end
		message_description = "An online order has been made:-#{order_description}"
		message = api.messages.build :to => "23054770162", :content => message_description, :from => "LeChatBleu"
		response = message.deliver
	end

	def resend_confirmation_code
		if self.confirmed
			{success: false, error_code: 4}
		elsif !self.expired  ## unless (expression) is same as if !(expression)
			if self.resent
				{:success => false, :error_code => 3}  #error code 3 is conf code has already been resent
			elsif (Time.now - 600).to_datetime >= self.created_at
				self.send_confirmation_code
				self.resent = true
				self.save
				{:success => true}
			else
				{:success => false, :error_code => 1}  #error code 1 not yet 10 min
			end
		else
			{:success => false, :error_code => 2}  #error code 2 is order expired
		end
	end

	def expired
		if (Time.now - 7200).to_datetime > self.created_at
			true
		else
			false
		end
	end

	private
		def init
			self.confirmed ||= false
			self.resent ||= false
		end

		def generate_confirmation_code
			digest = Digest::MD5.hexdigest "+lcb#{self.id}lcb-"
			conf_code = "#{self.id}-#{digest[0..2]}-#{digest[10..12]}"
			self.update_attributes confirmation_code: conf_code
		end
end
