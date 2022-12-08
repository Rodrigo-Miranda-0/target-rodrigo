# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard.title") }

  content title: proc { I18n.t("active_admin.dashboard.title") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard.welcome")
        small I18n.t("active_admin.dashboard.call_to_action")
      end
    end
  end
end
