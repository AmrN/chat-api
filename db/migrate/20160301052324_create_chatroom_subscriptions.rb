class CreateChatroomSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :chatroom_subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
    end
  end
end
