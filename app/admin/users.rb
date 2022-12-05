ActiveAdmin.register_page "Users" do
  menu priority: 2, label: proc { I18n.t("active_admin.users") }

  content title: proc { I18n.t("active_admin.users") } do
    # Show all registered users
    table_for User.all do
      column :id
      column :email
      column :name
      column :last_name
      column :created_at
      column :updated_at
    end
  end
end
