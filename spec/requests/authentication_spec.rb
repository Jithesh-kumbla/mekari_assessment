require 'rails_helper'

RSpec.describe 'Authentication', type: :request do

	describe 'POST /login' do
		let(:user) { FactoryBot.create(:user, first_name: 'TestUser', last_name: '01', email: 'user@gmail.com', password: 'password') }

		it 'will unauthorize the client' do
			post '/api/v1/login', params: { user_name: 'TestUser', password: 'password' }
			expect(response).to have_http_status(:unauthorized)
		end

		it 'will authorize the client' do
			user
			post '/api/v1/login', params: { email: user.email, password: user.password }
			expect(response).to have_http_status(:created)
			expect(response_body['user_id']).to eq(user.id)
		end
	end
end