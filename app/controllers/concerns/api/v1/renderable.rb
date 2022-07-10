module Api
	module V1
		module Renderable
			extend ActiveSupport::Concern

			included do
				rescue_from AuthorizationError, with: :handle_unauthorized_requests
				rescue_from ActionController::ParameterMissing, with: :parameter_missing
				rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
				rescue_from JWT::DecodeError, with: :jwt_decode_error
				rescue_from ActionController::ParameterMissing, with: :missing_parameters
			end

			private

			def missing_parameters(err)
				render_resp(err.message, :unauthorized)
			end

			def handle_unauthorized_requests
				render_resp('Unauthorized Access. Please check your token', :unauthorized)
			end

			def record_not_found(err)
				render_resp(err.message, :not_found)
			end

			def jwt_decode_error(err)
				render_resp(err.message, :unprocessable_entity)
			end

			def render_resp(msgs, sym)
				render json: {errors: msgs}, status: sym
			end
		end
	end
end