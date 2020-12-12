class CreateRadios < ActiveRecord::Migration[6.0]
  def change
    create_table :radios do |t|
      t.string :title
      t.string :introduction
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
