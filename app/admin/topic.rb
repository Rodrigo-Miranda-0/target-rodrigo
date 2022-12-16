ActiveAdmin.register Topic do
  permit_params :name, :image

  index do
    selectable_column
    id_column
    column :name
    column :image, as: :file
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Topic Details" do
      f.input :name
      f.input :image, as: :file
    end
    f.actions
  end
end
