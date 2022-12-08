ActiveAdmin.register Target do
  filter :topic_id, as: :select, collection: proc { Topic.all.map { |topic| [topic.name, topic.id] } }

  index do
    column :id
    column :title
    column :user_id
    column :topic_id
    column :created_at
    column :updated_at
  end
end
