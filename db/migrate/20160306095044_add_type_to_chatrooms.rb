class AddTypeToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :type, :string
  end
end
