class EditMessages2 < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :read, :boolean, default: false
    remove_reference :messages, :user, index: true, foreign_key: true
    remove_reference :messages, :conversation, index: true, foreign_key: true
    add_reference :messages, :user, null: false
    add_reference :messages, :conversation, null: false
  end
end
