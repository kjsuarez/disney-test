class CreateBonusFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :bonus_features do |t|
      t.string :name
      t.string :description
      t.datetime :releaseDate
      t.integer :duration
      t.belongs_to :feature

      t.timestamps
    end
  end
end
