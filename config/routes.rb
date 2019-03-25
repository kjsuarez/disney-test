Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'

  get 'feature/:feature_id' => 'features#getFeature'
  get 'features' => 'features#allFeatures'
  post 'feature/new' => 'features#addFeature'
  delete 'feature/:feature_id' => 'features#deleteFeature'
  put 'feature/:feature_id' => 'features#updateFeature'

  get 'bonuses' => 'bonus_features#allBonuses'
  get 'bonus/bonus_id' => 'bonus_features#getBonus'
  post 'feature/:feature_id/bonus/new' => 'bonus_features#addBonus'
  delete 'bonus/:bonus_id' => 'bonus_features#deleteBonus'
  put 'bonus/:bonus_id' => 'bonus_features#updateBonus'

  get 'series' => 'tv_shows#allShows'
  get 'series/:series_id' => 'tv_shows#getShow'
  post 'series/new' => 'tv_shows#addShow'
  post 'series/:series_id/season/new' => 'seasons#addSeason'
  delete 'series/:series_id' => 'tv_show#deleteShow'
  put 'series/:series_id' => 'tv_shows#updateShow'

  get 'seasons' => 'seasons#allSeasons'
  get 'season/:season_id' => 'seasons#getSeason'
  post 'season/:season_id/episode/new' => 'episodes#addEpisode'
  delete 'season/:season_id' => 'seasons#deleteSeason'
  put 'season/:season_id' => 'seasons#updateSeason'

  get 'episodes' => 'episodes#allEpisodes'
  get 'episode/:episode_id' => 'episodes#getEpisode'
  delete 'season/:season_id' => 'seasons#deleteSeason'
  put 'episode/:episode_id' => 'episodes#updateEpisode'
end
