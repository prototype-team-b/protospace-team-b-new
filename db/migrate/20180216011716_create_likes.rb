class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
       t.references :user, foreign_key: true, null: false
      t.references :prototype, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
