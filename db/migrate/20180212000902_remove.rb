class Remove < ActiveRecord::Migration
  def change
    drop_table :categories
    drop_table :prototype_categories
  end
end
