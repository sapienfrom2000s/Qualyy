FactoryBot.define do
  factory :user do
    name { "John" }
    email { "johndoe@example.com" }
    password { "password" }
    youtube_api_key { "randomstring" }
  end

  factory :channel do
    identifier { 'something' }
  end

  factory :filter do
    keywords { 'keyword1;keyword2' }
    non_keywords { 'nonkeyword1;nonkeyword2' }
    published_before { Date.new(2022, 12, 02) }
    published_after { Date.new(2022, 11, 02)}
    minimum_duration { 1 }
    maximum_duration { 14400 }
    videos { 50 }
  end
end
