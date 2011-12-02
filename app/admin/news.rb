ActiveAdmin.register News do
  index do
    column :title, sortable: false
    column :created_at
    default_actions
  end

  filter :title
  filter :created_at

  show title: :title do
    attributes_table :title, :content, :published_at
  end

  form do |f|
    f.inputs 'News Details' do
      f.input :title
      f.input :content
    end
    f.buttons
  end
end
