class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating, index: true
      t.references :user, index: true, foreign_key: true
      t.references :flag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
