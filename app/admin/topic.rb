ActiveAdmin.register Topic do
  # Create topics
  permit_params :name, :image

  # Show topics
  index do
    selectable_column
    id_column
    column :name
    column :image, as: :file
    column :created_at
    column :updated_at
    actions
  end

  # Edit topics

  form do |f|
    f.inputs "Topic Details" do
      f.input :name
      f.input :image, as: :file
    end
    f.actions
  end

  controller do
    def create
      Topic.create!(permitted_params[:topic])
      flash[:notice] = I18n.t("active_admin.topic.on_create")
      redirect_to admin_topics_path
    end

    def update
      Topic.find(params[:id]).update!(permitted_params[:topic])
      flash[:notice] = I18n.t("active_admin.topic.on_update")
      redirect_to admin_topics_path
    end

    def destroy
      topic = Topic.find(params[:id])
      topic.destroy
      flash[:notice] = I18n.t("active_admin.topic.on_destroy")
      redirect_to admin_topics_path
    end
  end
end
