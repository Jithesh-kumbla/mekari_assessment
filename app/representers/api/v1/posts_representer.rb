module Api
	module V1
		class PostsRepresenter

			attr_reader :posts

			def initialize(posts)
				@posts = posts
			end

			def serialize
				posts.map do |post|
					{
						id: post.id,
						title: post.title,
						body: post.body
					}
				end
			end

		end
	end
end