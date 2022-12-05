ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :name
    column :last_name
    column :created_at
    column :updated_at
  end
end
