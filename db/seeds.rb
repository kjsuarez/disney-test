# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

shows = TvShow.create([
  {name: "Star Wars: Clone Wars", description: "yada yada", releaseDate: "2003-11-07"},
  {name: "lost", description: "A plane crashes on a Pacific island, and the 48 survivors, stripped of everything, scavenge what they can from the plane for their survival. Some panic; some pin their hopes on rescue. The band of friends, family, enemies, and strangers must work together against the cruel weather and harsh terrain.", releaseDate: "2004-09-22"}
])

seasons = Season.create([
  {name: "Season 1", description: "yada yada", releaseDate: "2003-11-07", tv_show: shows.first},
  {name: "Season 1", description: "yada yada", releaseDate: "2004-09-22", tv_show: shows[1]}
])

episodes = Episode.create([
  {name: "Born to Run", description: "xxx", releaseDate: "2003-11-07", duration: 30000, season: seasons.first},
  {name: "???", description: "yyy", releaseDate: "2004-09-22", duration: 30000, season: seasons[1]}
])

feature = Feature.create({name: "Frozen", description: "Animated feature. Fearless optimist, the Princess Anna, sets off on an epic journey—teaming up with rugged mountain man, Kristoff, and his loyal reindeer Sven—to find her sister Elsa, whose icy powers have trapped the kingdom of Arendelle in eternal winter.", theatricalReleaseDate: "2013/11/4", duration: 30000})

bonus = BonusFeature.create({name: "Breaking the Ice", description: "Get to know frozen from the snowy ground up as the filmmakers and songwriters discuss the story's roots and inspiration; the joys of animating olaf, the little snowman with the sunny personality; and the creation of those amazing songs.", duration: 15, feature: feature})
