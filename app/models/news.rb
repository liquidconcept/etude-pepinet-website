class News < ActiveRecord::Base
  structure do
    title   :string, validates: [:presence, {length: { minimum: 5 }}]
    content :text,   validates: [:presence]

    timestamps
  end

  default_scope order('created_at DESC')
end

