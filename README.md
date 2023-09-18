# What is Qualyy

The idea is to scrape good content from youtube channels based on their views, comments, dislikes and likes. To get
additional control, user can filter based on title keywords, non keywords, date and time duration. I calculate
the metrics by a simple formula rating = (((comments/views)+(likes/views))/2)-(dislikes/views). Then, it is displayed in 
descending order. Do tell me if it can be improved.
*keywords should be seperated by ';'. And they act as `and` logical operator. `fish;turtle` fish and turtle both
must be present in the title. It is case insensitive.
*non-keywords again should be seperated by ';'. And they act as `or` logical operator. `fish;turtle` fish or turtle
is present in title, it will be filtered out.

# How does it work?

refer to #BackgroundJob and sockets

# Limitation

Youtube allows only 10,000 units per day. Use it wisely.
Youtubedislike api allows only 100 calls per minute. This
is why max 100 videos will be shown to user.

I have skipped the nested attributes form as I have forgotten some of it and it would require some
time to relearn it.

# TDD

I have been slacking to write TDD from past 5-6 projects. It has been atleast 5 months since I learned about
TDD. It always felt like a waste of time to focus on tests and then on development. The projects always forced
me to write tests. I had to write them after writing the code. It was painful.

Turning Point:

When I was doing social media clone. I read a article which gave some arguments on favour of Testing. One of the points
that hit me hard was 'Code can't be written perfectly on the first time. You need to refactor it to improve the quality.
And you need tests to make sure that you didn't break anything'.

Advantages of TDD(opinion):

Writing Tests first helps to break the logic. It forces you to think only in terms of passing that test. So,
you form the logic to just pass the test.

It's fun. It feels like playing a game.

# Maybe features

Filters can be improved by introducing minimum views and maximum views.

# Background Jobs & Websockets

It turns out that I can't call api from controller. It will timeout and block the browser till the request is completed.
It is better to make api calls in the background. When calls get successful, I can update user about the status through
broadcast messages. I won't be following TDD here as sidekiq and websockets is fairly new to me. So, I don't know what 
results to *expect*. I know that there will be three seperate api calls(potentially three background jobs to queue): 

1) first to *youtube* regarding *channel videos*
    to fetch snippets. In this call, I will go through all the channels user has saved. Here, I will filter: keywords,non-keywords, publishedAfter, publishedBefore and number of videos to fetch from each channel. In case of successful
    fetch from each channel, I can push a broadcast message to user which says 'Channel with #{id} was successfully scraped'. In case of error from api, I can push, 'Either channel id is wrong or there is some error from api'.
    *Keep in mind yt allows only 10000 quotas per day*

2) second to *youtube* regarding *videos* metadata
   It gives out a more detailed metadata on video. It is necessary to filter max and min time duration. It also fetches
   views, comments and likes. Look at error handling. Here I can broadcast on successful fetch 'Successfully fetched metadata of #{n} videos'. I need to store the video info in rails cache. Show warning if video length is > 100 videos.

3) third to *youtubedislikeapi* regarding *video* dislikes
    Very similar to second api. Finally push to db with calculated metrics, video metadata and update view with stream. When all the videos gets pushed display a sort button.

# Bugs

Published after and published before feature doesn't work. *fixed
sometimes generates duplicate result *fixed

# Todo

1. [this](https://github.com/sapienfrom2000s/Qualyy/blob/a28e24e35421d652f1a07b7b4b1f8922b02a7d6b/app/jobs/youtubeapi_call_to_fetch_channel_metadata_job.rb#L18) should be replaced with a specific error that is expected.
2. [this](https://github.com/sapienfrom2000s/Qualyy/blob/main/app/jobs/fetchvideometadata_job.rb#L40) creates too many objects, can be replaced with template string or string interpolation.
3. Faraday paralell requests can be used to reduce processing time
4. Add minimum and maximum views as filter
