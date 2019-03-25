class TvShow < ApplicationRecord
  self.table_name = 'tv_shows'
  has_many :seasons, dependent: :destroy
end
