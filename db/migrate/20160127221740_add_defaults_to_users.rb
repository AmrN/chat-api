class AddDefaultsToUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :username, :string, null: false
  end
end
