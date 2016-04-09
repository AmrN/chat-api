class CreateAcquaintanceships < ActiveRecord::Migration[5.0]
  def change
    create_table :acquaintanceships do |t|
      t.references :person, index: true, foreign_key: true
      t.references :acquaintance, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
      t.index [:person_id, :acquaintance_id], unique: true
      t.timestamps
    end
  end
end
