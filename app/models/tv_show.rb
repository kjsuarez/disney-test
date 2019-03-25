class TvShow < ApplicationRecord
  has_many :seasons, dependent: :destroy
end
