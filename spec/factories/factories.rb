FactoryBot.define do
  factory :user do
    name { "John" }
    email { "johndoe@example.com" }
    password { "password" }
    youtube_api_key { "randomstring" }
  end
end
