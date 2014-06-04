class AnnexeBooks < ActiveRecord::Base
  mount_uploader :file, FileUploader

  structure do
    title        :string,   validates: [:presence]
    content      :text,     validates: [:presence]
    category     :string,   validates: [:presence]
    link         :string
    file         :string

    timestamps
  end

end
