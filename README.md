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
5. run `rails s` to start the server locally
6. The webapp will be available at the given host:port

*(optional)* tests can be run through `bundle exec rspec`

# Todo

1. Faraday paralell requests can be used to reduce processing time
2. Error handling for quota exhaustion
3. Send meaningful popups to user regarding api calls in the background
4. Run rubocop through the project
5. Tests are flaky
6. Improve Album model association
