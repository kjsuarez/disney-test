Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'

  get 'feature/:feature_id' => 'features#getFeature'
  get 'features' => 'features#allFeatures'
  post 'feature/new' => 'features#addFeature'
  delete 'feature/:feature_id' => 'features#deleteFeature'
  put 'feature/:feature_id' => 'features#updateFeature'

  get 'bonuses' => 'bonus_features#allBonuses'
  post 'feature/:feature_id/bonus/new' => 'bonus_features#addBonus'

  get 'series' => 'tv_shows#allShows'
  get 'series/:series_id' => 'tv_shows#getShow'
  post 'series/new' => 'tv_shows#addShow'
  post 'series/:series_id/season/new' => 'seasons#addSeason'

  get 'seasons' => 'seasons#allSeasons'
  get 'season/:season_id' => 'seasons#getSeason'
  post 'season/:season_id/episode/new' => 'episodes#addEpisode'

  get 'episodes' => 'episodes#allEpisodes'
  get 'episode/:episode_id' => 'episodes#getEpisode'
end
