class User < ApplicationRecord
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :first_name, presence: true, length: {minimum: 3, maximum: 23}
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}
end
