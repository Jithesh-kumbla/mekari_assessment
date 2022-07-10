FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'user' }
    email { 'test@gmail.com' }
    password { 'password' }
  end
end
