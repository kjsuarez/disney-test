class Season < ApplicationRecord
  belongs_to :tv_series
  has_many :episodes
end
