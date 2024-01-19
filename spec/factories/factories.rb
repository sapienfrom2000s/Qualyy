FactoryBot.define do
  factory :user do
    name { 'John' }
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password { 'password' }
    youtube_api_key { 'randomstring' }
  end

  factory :channel do
    sequence(:identifier) { |n| "randomchannelid#{n}" }
    sequence(:name){|n| "Channel_#{n}"}
    keywords { 'keyword1;keyword2' }
    non_keywords { 'nonkeyword1;nonkeyword2' }
    published_before { Date.new(2_022, 12, 0o2) }
    published_after { Date.new(2_022, 11, 0o2) }
    minimum_duration { 1 }
    maximum_duration { 14_400 }
    no_of_videos { 50 }
  end

  factory :video do
    sequence(:identifier) { |n| "randomvideoid#{n}" }
    sequence(:duration, 7_322)
    sequence(:views, 1_000)
    sequence(:comments, 20)
    sequence(:rating, 90)
    sequence(:title) { |n| "randomtitle#{n}" }
  end

  factory :album do
    sequence(:name) { |n| "Music_#{n}" }
  end
  
end
