class Feature < ApplicationRecord
  has_many :bonus_features, dependent: :destroy
end
