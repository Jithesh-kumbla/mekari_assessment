require 'rails_helper'

RSpec.describe Api::V1::AuthenticationTokenService do

	context 'JWT encode decode' do
		let(:user) { FactoryBot.create(:user, first_name: 'test_user', email: 'test_user@gmail.com', password: 'testing') }
		let(:token) {described_class.encode(user.id)}
		it 'returns authentication token' do
			decoded_token = JWT.decode(
				token,
				described_class::HMAC_SECRECT, 
				true, 
				{algorithm: described_class::ALGORITHM_TYPE}
			)

			expect(decoded_token).to eq([{"user_id"=> user.id}, {"alg"=>"HS256"}])
	  end
	end
end