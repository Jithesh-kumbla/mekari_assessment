module Api
  module V1
    class AuthenticationTokenService
    	HMAC_SECRECT = 'mekari_secret_0123'#This secret can be kept in credentials.yml.enc but for simplicity I have added it here.
    	ALGORITHM_TYPE = 'HS256'

      def self.encode(user_id)
      	payload = {user_id: user_id}
      	JWT.encode(payload, HMAC_SECRECT, ALGORITHM_TYPE)
      end

      def self.decode(token)
      	decoded_token = JWT.decode(token, HMAC_SECRECT, true, {algorithm: ALGORITHM_TYPE})
      	decoded_token[0].dig('user_id')
      end
    end
  end
end