class Episode < ApplicationRecord
  self.table_name = 'episodes'
  belongs_to :season
end
