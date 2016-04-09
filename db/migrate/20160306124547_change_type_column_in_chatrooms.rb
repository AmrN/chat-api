class ChangeTypeColumnInChatrooms < ActiveRecord::Migration[5.0]
  def change
    rename_column :chatrooms, :type, :room_type
  end
end
