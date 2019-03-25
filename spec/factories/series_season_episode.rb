FactoryGirl.define do

  factory :tv_show do
    name "...In Translation"
    releaseDate "2004/09/22"
    description "yada yada"

    factory :series_with_season do
      after(:create) do |series|
        create(:season_with_episode, tv_show: series)
      end
    end
  end

  factory :season do
    name "season 1"
    description "its a season"
    releaseDate "2004/09/22"

    factory :season_with_episode do
      after(:create) do |season|
        create(:episode, season: season)
      end
    end
  end

  factory :episode do
    name "...In Translation"
    description "gosh"
    releaseDate "2004/09/22"
    duration "42"

  end
end
