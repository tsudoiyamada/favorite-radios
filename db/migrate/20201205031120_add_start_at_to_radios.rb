class AddStartAtToRadios < ActiveRecord::Migration[6.0]
  def change
    add_column :radios, :start_at, :datetime
  end
end
