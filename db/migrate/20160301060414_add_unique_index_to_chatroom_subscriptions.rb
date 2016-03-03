class AddUniqueIndexToChatroomSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_index :chatroom_subscriptions, [:user_id, :chatroom_id], unique: true
  end
end
