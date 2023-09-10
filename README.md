# README

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