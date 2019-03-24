Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'

  post 'feature/new' => 'features#addFeature'
  post 'feature/:feature_id/bonus/new' => 'bonus_features#addBonus'

  post 'series/new' => 'tv_shows#addShow'
  post 'series/:series_id/season/new' => 'seasons#addSeason'

  post 'season/:season_id/episode/new' => 'episodes#addEpisode'

end
