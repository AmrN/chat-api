class AddOneToOneToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :one_to_one, :boolean
  end
end
