class BonusFeature < ApplicationRecord
  self.table_name = 'bonus_features'
  belongs_to :feature
end
