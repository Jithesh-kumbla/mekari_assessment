module Api
	module V1
		class BaseController < ApplicationController
			include ActionController::HttpAuthentication::Token
			include Api::V1::Renderable
			attr_reader :current_user

			before_action :login_required

			private

			def login_required
				token, _options = token_and_options(request) 
				raise AuthorizationError unless token
				user_id = AuthenticationTokenService.decode(token)
				@current_user = User.find(user_id)
			end

			def user
				@user ||= User.find_by(email: params.require(:email))
			end
		end
	end
end