FactoryBot.define do
  factory :user do
    name { "John" }
    sequence(:email) {|n| "johndoe#{n}@example.com" }
    password { "password" }
    youtube_api_key { "randomstring" }
  end

  factory :channel do
    sequence(:identifier) { |n| "randomchannelid#{n}" }
    keywords { 'keyword1;keyword2' }
    non_keywords { 'nonkeyword1;nonkeyword2' }
    published_before { Date.new(2022, 12, 02) }
    published_after { Date.new(2022, 11, 02)}
    minimum_duration { 1 }
    maximum_duration { 14400 }
    no_of_videos { 50 }
  end

  factory :video do
    sequence(:identifier) { |n| "randomvideoid#{n}" }
    sequence(:duration,7322)
    sequence(:views, 1000)
    sequence(:comments, 20)
    sequence(:rating, 90)
    sequence(:title) { |n| "randomtitle#{n}" }
  end
end
