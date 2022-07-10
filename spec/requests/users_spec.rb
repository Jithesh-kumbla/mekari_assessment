require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do

	context 'POST /signup' do
		it 'will create a new user' do
			post '/api/v1/signup', params: { user: {first_name: 'TestUser', last_name: '01', email: 'user@gmail.com', password: 'password'} }
			expect(response).to have_http_status(:created)
		end
	end
end