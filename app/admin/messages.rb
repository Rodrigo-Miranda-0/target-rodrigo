ActiveAdmin.register Message do
  index do
    selectable_column
    column :conversation
    column "Sender", :user
    column :content
    column "Sent at", :created_at
    actions
  end
end
