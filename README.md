# Setup

Assuming you have a rails environment already set up-


* install gems- `$ bundle install`

* migrate database- `$ rails db:migrate`

* seed database- `$ rails db:seed`

* start server on localhost:3000- `$ rails server`

* run tests- `$ bundle exec rspec spec`

# API endpoints

 * get 'feature/:feature_id'
 * get 'features'
 * post 'feature/new'
 * delete 'feature/:feature_id'
 * put 'feature/:feature_id'

 * get 'bonuses'
 * get 'bonus/bonus_id'
 * post 'feature/:feature_id/bonus/new'
 * delete 'bonus/:bonus_id'
 * put 'bonus/:bonus_id'

 * get 'series'
 * get 'series/:series_id'
 * post 'series/new'
 * post 'series/:series_id/season/new'
 * delete 'series/:series_id'
 * put 'series/:series_id'

 * get 'seasons'
 * get 'season/:season_id'
 * post 'season/:season_id/episode/new'
 * delete 'season/:season_id'
 * put 'season/:season_id'

 * get 'episodes'
 * get 'episode/:episode_id'
 * delete 'season/:season_id'

 ## Sample body for GET 'feature/:feature_id'

 `{"feature": {"name": "heck", "description": "floop", "theatricalReleaseDate": "2013/11/4", "duration": 30000}}`

 # Database Structure

 I couldn't find a great answer for multiple table inheritance with Rails, so I opted to make 'Title' the parent model of all other models without actually giving it a table.  Feature, Bonus, Series, Season and Episode all have title's presumed attributes built into their own tables. I also decided to make Features posses bonuses intsead of letting all Titles posses them. Other then that you're provided data model is intact.

 * Series have many seasons
 * Seasons have many Episodes
 * Features have many Bonuses

 # Testing

 Given the time constraints I decied to focus my testing efforts of the controller layer since the provided models are fairly straight forword.
