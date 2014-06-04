ActiveAdmin.register AnnexeBooks do
  form(:html => { :multipart => true }) do |f|
    f.inputs "Annexes livres" do
      f.input :title
      f.input :category
      f.input :content
      f.input :link
      f.input :file, :as => :file
    end
    f.buttons
  end
end
