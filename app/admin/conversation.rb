ActiveAdmin.register Conversation do
  index do
    selectable_column
    id_column
    column :user1
    column :user2
    column "Messages" do |conversation|
      link_to "View Messages", admin_messages_path(q: { conversation_id_eq: conversation.id }), label: "Messages"
    end
    column :created_at
    actions
  end
end
