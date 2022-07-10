module Api
	module V1
		class UsersRepresenter

			attr_reader :users

			def initialize(users)
				@users = users
			end

			def serialize
				users.map do |user|
					{
						id: user.id,
						first_name: user.first_name,
						last_name: user.last_name,
						email: user.email
					}
				end
			end
		end
	end
end