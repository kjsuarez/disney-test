FactoryGirl.define do
  factory :feature do
    name "Frozen"
    description "Animated feature. Fearless optimist, the Princess Anna, sets off on an epic journey—teaming up with rugged mountain man, Kristoff, and his loyal reindeer Sven—to find her sister Elsa, whose icy powers have trapped the kingdom of Arendelle in eternal winter."
    theatricalReleaseDate "11/27/2013"
    duration "102"

    factory :feature_with_bonus do
      after(:create) do |feature|
        create(:bonus_feature, feature: feature)
      end
    end
  end

  factory :bonus_feature do
    name "Deleted Scene: Meet Kristoff 2 - Introduction By Directors"
    description "Kristoff goes mountain climbing with a friend. With an introduction by directors chris buck and jennifer lee."
    duration "13"    
  end
end
