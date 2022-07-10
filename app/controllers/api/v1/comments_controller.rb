module Api
	module V1
		class CommentsController < BaseController

			before_action :set_post, only: [:create]
		
			def create
				comment = Comment.new(comments_params)
				if comment.save
					render json: Api::V1::CommentsRepresenter.new([comment]).serialize, status: :created
				else
					render json: {errors: comment.errors}, status: :unprocessable_entity
				end
			end

			private

			def set_post
				@post = Post.find(params[:post_id])
			end

			def comments_params
				opts = params.permit(:body, :post_id, :parent_id)
				opts.merge!(user: current_user, post: @post)
				opts
			end
		end
	end
end