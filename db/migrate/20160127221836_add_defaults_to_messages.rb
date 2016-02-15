class AddDefaultsToMessages < ActiveRecord::Migration[5.0]
  def up
    change_column :messages, :content, :text, null: false
  end
end
