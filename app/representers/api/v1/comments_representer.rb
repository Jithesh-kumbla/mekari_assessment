module Api
	module V1
		class CommentsRepresenter

			attr_reader :comments

			def initialize(comments)
				@comments = comments
			end

			def serialize
				comments.map do |comment|
					{
						id: comment.id,
						body: comment.body,
						user_id: comment.user_id,
						post_id: comment.post_id,
						parent_id: comment.parent_id
					}
				end
			end
		end
	end
end