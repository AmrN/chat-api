class AddFriendToAcquaintanceships < ActiveRecord::Migration[5.0]
  def change
    add_column :acquaintanceships, :friend, :boolean
  end
end
