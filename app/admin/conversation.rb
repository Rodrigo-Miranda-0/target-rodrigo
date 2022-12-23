ActiveAdmin.register Conversation do
  index do
    selectable_column
    id_column
    column :user1
    column :user2
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user1
      row :user2
      row :created_at
      row :updated_at
    end

    panel 'Messages' do
      table_for conversation.messages do
        column :user_id
        column :content
        column :created_at
      end
    end
  end
end
