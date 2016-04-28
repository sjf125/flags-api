class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :location
      t.string :name
      t.string :level
      t.string :imgurl

      t.timestamps null: false
    end
  end
end
