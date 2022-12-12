ActiveAdmin.register Target do
  index do
    column :id
    column :title
    column :user_id
    column :topic_id
    column :created_at
    column :updated_at
  end
end
