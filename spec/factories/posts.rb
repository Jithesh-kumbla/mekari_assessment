FactoryBot.define do
  factory :post do
    title { "My new post" }
    body { "My new post body" }
    user { nil }
  end
end
