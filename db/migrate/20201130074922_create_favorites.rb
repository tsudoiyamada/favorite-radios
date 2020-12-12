class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :radio, null: false, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :radio_id], unique: true
    end
  end
end
