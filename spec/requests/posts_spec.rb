require 'rails_helper'

RSpec.describe 'Post Request spec', type: :request do

	before do
		@user = FactoryBot.create(:user)
		@token = Api::V1::AuthenticationTokenService.encode(@user.id)
	end
	
	describe 'posts /api' do
		context 'POST /posts' do
			it 'create a new book' do
				expect {
					post '/api/v1/posts', params: {post: {title: 'test title', body: 'test body'}}, headers: {'Authorization' => "Bearer #{@token}"}
				}.to change {Post.count}.from(0).to(1)

				expect(response).to have_http_status(:created)
			end
		end

		context 'GET /posts' do
			let!(:post) { FactoryBot.create(:post, title: 'my test post', body: 'my test body', user: @user) }
			let(:user_two) { FactoryBot.create(:user, first_name: 'test_user2', email: 'test_user@gmail.com', password: 'password') }
			let(:user_two_post) { FactoryBot.create(:post, title: 'user two created post', body: 'user two created body', user: user_two)  }

			it 'returns all posts created by user' do
				get '/api/v1/posts', headers: {'Authorization' => "Bearer #{@token}"}
				expect(response_body.first).to eq({
					"body"=> post.body, 
					"id"=> post.id, 
					"title"=> post.title
				})
			end

			it 'returns post created by another user_two' do
				user_two_post
				get '/api/v1/posts', params: {user_id: user_two.id} ,headers: {'Authorization' => "Bearer #{@token}"}
				expect(response_body.first).to eq({
					"body"=> user_two_post.body, 
					"id"=> user_two_post.id, 
					"title"=> user_two_post.title
				})
			end
		end
	end
end