ActiveAdmin.register About do
  menu label: "About"

  config.clear_sidebar_sections!
  config.filters = false
  config.batch_actions = false
  config.clear_action_items!

  permit_params :content

  index do
    column :content
    actions
  end
end
