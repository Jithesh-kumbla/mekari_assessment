module Api
	module V1
		class AuthenticationController < BaseController
			skip_before_action :login_required

			#login method
			def create
				raise AuthorizationError unless user && user.authenticate(params.require(:password))
				token  = AuthenticationTokenService.encode(user.id)
				render json: {token: token, user_id: user.id}, status: :created
			end
			
		end
	end
end