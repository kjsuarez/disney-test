class AddFieldsToFeature < ActiveRecord::Migration[5.2]
  # def change
  #   add_column :features, :name, :string
  #   add_column :features, :description, :string
  # end

  def up
    add_column :features, :name, :string
    add_column :features, :description, :string

    change_column_null :features, :name, false
    change_column_null :features, :description, false
  end

  def down
    remove_column :features, :name, :string
    remove_column :features, :description, :string
  end
end
