class BookUpdates < ActiveRecord::Base
  mount_uploader :file, FileUploader

  structure do
    title               :string,   validates: [:presence]
    content             :text,     validates: [:presence]
    chapter             :string,   validates: [:presence]
    file                :string
    article_number      :integer
    alinea              :string


    timestamps
  end

end
