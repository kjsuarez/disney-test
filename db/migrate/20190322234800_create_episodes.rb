class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :name
      t.string :description
      t.datetime :releaseDate
      t.integer :duration
      t.belongs_to :season
      t.timestamps
    end
  end
end
