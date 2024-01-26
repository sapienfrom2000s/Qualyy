# What is Qualyy

The core idea is to list videos from a youtube channel in decreasing
order of like to dislike ratio. 

# Limitation

Youtube allows only 10,000 units per day. Youtubedislike api allows 100 calls
per minute and 10,000 call per day.

# Installation

1. Make sure you have ruby 3.1.2 and postregsql
2. Clone the repo
3. cd into the directory
4. run `bundle install`
5. start sidekiq by `bundle exec sidekiq`
6. open another terminal, cd into project and run `rails s` to start the server locally
7. The webapp will be available at the given host:port

*(optional)* tests can be run through `bundle exec rspec`

# Screencast

![Peek recording itself](https://raw.githubusercontent.com/sapienfrom2000s/Qualyy/main/public/screencast.gif)

# Making your first request 

1. Sign Up with correct youtube API Key(you can use `AIzaSyD_y9yJRL7bAcwI7Zsy4v7TE-Z_iPeVFm0`).
2. Log in to your account.
3. Click on Add Album. Name it *Music* and save it.
4. Click on Add Channel. 
5. Enter `UCewyFby3pwB31EPE1PpCT1Q` in Channel ID and save it.
6. Click on Make Request. The API calls will start in background.
7. Go back and click on Videos. You might start to see some videos as they
   process in the background. Refresh window to see the updated list. 

   *Two of the fields that channel modal have is keywords and nonkeywords which can
   be a bit confusing. So, if I want certain keywords to be in video title we add
   through it. Say we want *music* and *lyrical* to be present in video title. We
   enter `music;lyrical`(seperated by semicolons) in the textbox.*

# Todo

1. Faraday paralell requests can be used to reduce processing time
2. Error handling for quota exhaustion
3. Send meaningful popups to user regarding api calls in the background
4. go through some of the suggestions made by rubocop
5. Tests are flaky
6. ~~Improve Album model association~~
7. Class which processes background job is messy. Better organisation
   required.
8. Move keywords and nonkeywords a part of frontend in filters.
