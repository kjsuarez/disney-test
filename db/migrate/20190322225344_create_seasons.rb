class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :name
      t.string :description
      t.datetime :releaseDate
      t.belongs_to :tv_show
      t.timestamps
    end
  end
end
