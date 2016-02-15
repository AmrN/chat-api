class RemoveDefaultFromUsersRole < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :role, :string, default: ""
  end
end
