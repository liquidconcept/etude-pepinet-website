ActiveAdmin.register News do
  index do
    column :title, sortable: false
    column :created_at
    default_actions
  end

  filter :title
  filter :created_at

  show title: :title do
    attributes_table :title, :content, :created_at
  end
end
