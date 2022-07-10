module Api
	module V1
		class PostsController < BaseController
			before_action :set_user_posts, only: [:index]

			def index
				posts = @user.posts.left_outer_joins(:comments).group('posts.id').order(count: :desc)
				render json: Api::V1::PostsRepresenter.new(posts).serialize
			end

			def create
				post = Post.new(post_params.merge!(user: current_user))
				if post.save 
					render json: Api::V1::PostsRepresenter.new([post]).serialize, status: :created
				else	
					render json: {errors: post.errors}, status: :unprocessable_entity
				end
			end

			private

			def set_user_posts
				@user = User.find(params[:user_id]) if params[:user_id].present?
				@user ||= current_user
			end

			def post_params
				params.require(:post).permit(:title, :body)
			end
		end
	end
end