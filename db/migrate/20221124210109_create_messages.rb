class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true
      t.timestamps

      t.index [:user_id, :conversation_id], unique: true
    end
  end
end
