class CreateTvSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_series do |t|
      t.string :name
      t.string :description
      t.datetime :releaseDate

      t.timestamps
    end
  end
end
