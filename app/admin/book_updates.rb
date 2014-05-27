ActiveAdmin.register BookUpdates do
  form(:html => { :multipart => true }) do |f|
    f.inputs "Update livre" do
      f.input :title
      f.input :content
      f.input :chapter
      f.input :alinea
      f.input :file, :as => :file
    end
    f.buttons
  end
end
