class Feature < Title
  self.table_name = 'features'
  has_many :bonus_features, dependent: :destroy
end
