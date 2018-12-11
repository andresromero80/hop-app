require 'rubystats/normal_distribution'

class UserVerification
	private
		attr_accessor :user, :client, :norm, :response

		def initialize(user)
			@user = user
			@norm = Rubystats::NormalDistribution.new(10, 2)
			@client = Nexmo::Client.new(
				api_key: ENV["SMS_API_KEY"],
			  api_secret: ENV["SMS_API_SECRET"]
			)

		end

	public

		def cancel(request_id)
			@response = get_client.cancel(request_id)
		end

		def verify(code, request_id)
			@response = get_client.verify.check(request_id: request_id, code: code)
			if @response
				if response.status == '0'
					@user.update(is_verified: true)
				  puts "Verification complete, event_id=#{@response.event_id}"
				else
				  puts "Error: #{@response.error_text}"
				end

				return @response
			end
		end

		def send_verification_code
			@response = get_client.verify.request(number: "33#{@user.number}", brand: 'HOP')
			if @response
				if @response.status == '0'
				  puts "Started verification request_id=#{@response.request_id}"
				else
				  puts "Error: #{@response.error_text}"
				end
			end

			return @response
		end

		def get_client
			@client
		end

		def get_user
			@user
		end

		def set_user(user)
			@user = user
		end
end