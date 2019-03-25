class Season < ApplicationRecord
  self.table_name = 'seasons'
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy
end
