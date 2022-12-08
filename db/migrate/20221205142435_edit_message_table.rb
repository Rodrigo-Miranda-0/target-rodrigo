class EditMessageTable < ActiveRecord::Migration[7.0]
  def change
    remove_index :messages, [:user_id, :conversation_id]
  end
end
