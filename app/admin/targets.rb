ActiveAdmin.register_page "Targets" do
  menu priority: 2, label: proc { I18n.t("active_admin.targets") }

  content title: proc { I18n.t("active_admin.targets") } do
    # Show all registered targets
    table_for Target.all do
      column :id
      column :title
      column :user_id
      column :topic_id
      column :created_at
      column :updated_at
    end
  end
end
