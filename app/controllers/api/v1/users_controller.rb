module Api
	module V1
		class UsersController < BaseController
			skip_before_action :login_required

			def index
				user = User.all
				render json: {users: user}, status: :success
			end

			def create
				user = User.new(user_params)
				if user.save
					session[:user_id] = user.id
					token = AuthenticationTokenService.encode(user.id)
					render json: Api::V1::UsersRepresenter.new([user]).serialize.push({token: token}), status: :created
				else
					render json: {error: user.errors}, status: :unprocessable_entity
				end 
			end

			private

			def user_params
				params.require(:user).permit(:first_name, :last_name, :email, :password)
			end
		end
	end
end