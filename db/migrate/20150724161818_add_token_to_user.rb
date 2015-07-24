class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, null: false
    add_index :users, :token, unique: true
  end
end
