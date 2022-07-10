require 'rails_helper'

RSpec.describe 'Post Request spec', type: :request do

	before do
		@user = FactoryBot.create(:user)
		@post = FactoryBot.create(:post, user: @user)
		@token = Api::V1::AuthenticationTokenService.encode(@user.id)
	end
	
	describe 'POST /api' do
		context 'POST /comments' do
			it 'create a new comment' do
				expect {
					post "/api/v1/posts/#{@post.id}/comments", params: { body: 'test body'}, headers: {'Authorization' => "Bearer #{@token}"}
				}.to change {Comment.count}.from(0).to(1)

				expect(response).to have_http_status(:created)
			end

			it 'should create a child comment' do
				comment = FactoryBot.create(:comment, body: 'Parent comment',user: @user, post: @post)
				expect {
					post "/api/v1/posts/#{@post.id}/comments", params: { body: 'Child comment has been created'}, headers: {'Authorization' => "Bearer #{@token}"}
				}.to change {Comment.count}.from(1).to(2)
				expect(response_body.first.dig('body')).to eq('Child comment has been created')
			end
		end
	end
end